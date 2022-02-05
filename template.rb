require "fileutils"
require "shellwords"

# This template is based on https://github.com/excid3/jumpstart/blob/master/template.rb

def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("spark-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      "https://github.com/mcalilly/spark.git",
      tempdir
    ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{spark/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def rails_version
  @rails_version ||= Gem::Version.new(Rails::VERSION::STRING)
end

def rails_7_or_newer?
  Gem::Requirement.new(">= 7.0.1").satisfied_by? rails_version
end

unless rails_7_or_newer?
  puts "Please use Rails 7.0.1 or newer to create a Spark application"
end

def add_gems
  # remove sqlite
  gsub_file "Gemfile", /^gem\s+["']sqlite3["'].*$/,'gem "pg"'

  gem "devise"
  gem "pundit"

  gem_group :test do
    gem 'minitest-reporters'
    gem 'launchy'
  end

  gem_group :development, :test do
    gem 'pry'
    gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  end
end

def set_application_name
  # Never add stylesheets when running rails scaffold
  environment "config.generators  { |g| g.scaffold_stylesheet false }"
  # Announce the user where they can change the application name in the future.
  puts "You can change application name inside: ./config/application.rb"
end

def add_authentication
  generate "devise:install"
  generate "devise:views"

  # Configure Devise to handle TURBO_STREAM requests like HTML requests
  inject_into_file "config/initializers/devise.rb", "  config.navigational_formats = ['/', :html, :turbo_stream]", after: "Devise.setup do |config|\n"

  # Use this until devise works with Hotwire
  inject_into_file "config/initializers/devise.rb", "config.parent_controller = 'TurboDeviseController'", after: "# Configure the parent class to the devise controllers.\n"

  inject_into_file 'config/initializers/devise.rb', after: "# frozen_string_literal: true\n" do <<~EOF
    class TurboFailureApp < Devise::FailureApp
      def respond
        if request_format == :turbo_stream
          redirect
        else
          super
        end
      end
      def skip_format?
        %w(html turbo_stream */*).include? request_format.to_s
      end
    end
  EOF
  end

  inject_into_file 'config/initializers/devise.rb', after: "# ==> Warden configuration\n" do <<-EOF
  config.warden do |manager|
    manager.failure_app = TurboFailureApp
  end
  EOF
  end

  # Set up devise password mailer in development
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'
  # Set up devise password mailer in test
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'test'

  # Add initial production settings for Amazon Simple Email Service
  inject_into_file 'config/environments/production.rb', after: "# config.action_mailer.raise_delivery_errors = false\n" do <<-EOF
  # Use Amazon Simple Email Service for password resets
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: "https://example.com" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "email-smtp.us-east-2.amazonaws.com",
    user_name: "UPDATE THIS WITH Rails.application.credentials.dig(:aws, :smtp_user_name)",
    password: "UPDATE THIS WITH Rails.application.credentials.dig(:aws, :smtp_password)",
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
  EOF
  end

  generate :devise, "User", "role:integer"
end

def add_authorization
  generate "pundit:install"
  # create default admin / member enum role
end

def add_css
  rails_command "tailwindcss:install"
end

def add_javascript
  # Confirm that Turbo is wired up correctly
  inject_into_file 'app/javascript/controllers/application.js', after: "window.Stimulus   = application\n" do <<-EOF
  \n
  // Use AlpineJS as a module
  import Alpine from 'alpinejs'
  window.Alpine = Alpine
  Alpine.start()
  \n
  // Delete this whenever. Just here to confirm that Turbo is working
  document.addEventListener("turbo:load", () => {
    console.log("Turbo is working on each visit!")
  })
  \n
  EOF
  end

  # Add  AlpineJS
  inject_into_file 'config/importmap.rb', after: 'pin_all_from "app/javascript/controllers", under: "controllers"' do <<-EOF
  \n
  pin "alpinejs", to: "https://unpkg.com/alpinejs@3.8.1/dist/module.esm.js", preload: true
  \n
  EOF
  end
end

def add_active_storage
  rails_command "active_storage:install"
end

def add_action_text
  rails_command "action_text:install"
end

def add_generator_configs
  inject_into_file 'config/application.rb', after: "# Configuration for the application, engines, and railties goes here.\n" do <<-EOF
    # Customize the rails generators
    config.generators do |g|
      g.scaffold_stylesheet false
    end
  EOF
  end
end

def add_static_pages
  generate :controller, "static_pages home about contact"
end

def add_settings
  generate "scaffold Setting site_title:string site_tagline:string site_description:text email:string phone:string address_line_one:string address_line_two:string city:string state_or_province:string postal_code:string country:string instagram_handle:string twitter_handle:string facebook_handle:string"
end

def copy_templates
  # first remove files you want to copy so the user doesn't have to confirm with y/n in their terminal
  remove_file ".ruby-version"
  remove_file "Procfile"
  remove_file "app/controllers/settings_controller.rb"
  remove_dir "app/views/settings"
  remove_file "test/controllers/settings_controller_test.rb"
  remove_file "test/system/settings_test.rb"

  # Now copy any files from Spark that you removed
  copy_file "Procfile"

  # copying directories will copy any files within these directories, recursively, that are different from what's already in the app you just created.
  directory "app", force: true
  directory "config", force: true
  directory "db", force: true
  directory "test", force: true
  directory "public", force: true
end

def setup_the_db
  rails_command "db:drop"
  rails_command "db:create"
  rails_command "db:migrate"
  rails_command "db:seed"
end

def format_gemfile
  # copy a cleanly formatted gemfile
  remove_file "Gemfile"
  copy_file "Gemfile"
  # double check that the new Gemfile didn't create an error
  rails_command "bundle:install"
  # run with clean bundle environment
  run "bundle lock --add-platform x86_64-linux"
end

def configure_render_deployment
  inject_into_file 'config/database.yml', after: "database: #{original_app_name}_production\n" do <<-EOF
  url: <%= ENV['DATABASE_URL'] %>
  EOF
  end
  gsub_file "config/puma.rb", '# workers ENV.fetch("WEB_CONCURRENCY") { 2 }', 'workers ENV.fetch("WEB_CONCURRENCY") { 4 }'
  gsub_file "config/puma.rb", '# preload_app!', 'preload_app!'
  gsub_file "config/environments/production.rb", 'config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?', 'config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present? || ENV["RENDER"].present?'

  copy_file "bin/render-build.sh"
  run "chmod a+x bin/render-build.sh"

  copy_file "render.yaml"
  gsub_file "render.yaml", '  - name: mysite', "  - name: #{original_app_name}_production"
  gsub_file "render.yaml", '    databaseName: mysite', "    databaseName: #{original_app_name}_production"
  gsub_file "render.yaml", '    user: mysite', "    user: #{original_app_name}_admin"
  gsub_file "render.yaml", '    name: mysite', "    name: #{original_app_name}_production"
  gsub_file "render.yaml", '          name: mysite', "          name: #{original_app_name}_production"
end

# Main setup
add_template_repository_to_source_path
add_gems

after_bundle do
  set_application_name
  add_authentication
  add_authorization
  add_css
  add_javascript
  add_active_storage
  add_action_text
  add_generator_configs
  add_static_pages
  add_settings

  copy_templates

  setup_the_db

  format_gemfile

  # Run tests
  rails_command "test:all"

  # Optional: configure Render
  configure_render_deployment if yes?("Do you want to deploy to Render?")

  # Commit everything to git
  unless ENV["SKIP_GIT"]
    git :init
    git add: "."
    # git commit will fail if user.email is not configured
    begin
      git commit: %( -m "Initial commit" )
    rescue StandardError => e
      puts e.message
    end
  end

  say
  say "Your app was successfully Spark-ed up! Tests should be green if everything was installed properly ; )", :green
  say
  say "### Next Steps ###", :blue
  say "1. Don't forget to move your new app to the correct directory on your local machine. Example: `mv ./#{original_app_name} ../ && cd ../#{original_app_name} && rails s`", :blue
  say
  say "2. Update config/environments/production.rb with your mailer domain and set up your Amazon keys to send password reset emails in production", :blue
  say
  say "3. Make sure you have libvips (brew install vips) or any of the other depedencies required for Active Storage that Rails does not install for you. More on that at https://edgeguides.rubyonrails.org/active_storage_overview.html#requirements", :blue
  say
  say "4. Update views/layouts/shared/metadata to use the canonical domain for your new site. You might also want to add default meta image for twitter and facebook links", :blue
  say
  say
  say "### Render Deployment Checklist ###", :cyan
  say
  say "* Make sure your app is deployed to Github and you've connected your Github account to Render while logged into the Render Dashboard", :cyan
  say
  say "* On the Render Dashboard, go to the Blueprint page and click the New Blueprint Instance button. Select your repository (after giving Render the permission to access it, if you haven’t already).", :cyan
  say
  say "* In the deploy window, set the value of the RAILS_MASTER_KEY to the contents of your config/master.key file. Then click Approve. Here's an example of how to get your RAILS_MASTER_KEY: run `EDITOR='atom --wait' rails credentials:edit` then navigate to config/master.key to copy it (make sure the master key is not checked into git). Note: this is note your Do not add the SECRET_KEY_BASE", :cyan
  say
  say "* You'll need to run `rails db:migrate` and `rails db:seed` from the shell inside your new Render webservice or you'll see a Rails error page", :cyan
  say
  say "* To set up a custom domain, refer to the Render docs here: https://render.com/docs/custom-domains. Here are the docs specically for Cloudflare DNS settings: https://render.com/docs/configure-cloudflare-dns", :cyan
end
