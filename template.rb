require "fileutils"
require "shellwords"

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

  gem "requestjs-rails"
  gem "image_processing"
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
  # Add Application Name to Config
  environment "config.application_name = Rails.application.class.module_parent_name"

  config.generators do |g|
    g.stylesheets false
  end

  something('hello') { g.stylesheets false }

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

  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'

  generate :devise, "User", "role:integer"
end

def add_authorization
  generate "pundit:install"
  # create default admin / guest enum role
end

def add_css
  rails_command "tailwindcss:install"
end

def add_javascript
  # importmap-rails
  # confirm stimulus is working & turbo with test controllers that print to console.log
end

def add_active_storage
  # to do
end

def add_action_text
  # to do
end

def add_static_pages
  generate :controller, "static_pages home about contact"
end

def add_settings
  generate "scaffold Setting site_title:string site_tagline:string site_description:text email:string phone:string address_line_one:string address_line_two:string city:string state_or_province:string postal_code:string country:string instagram_handle:string twitter_handle:string facebook_handle:string"
end

def copy_templates
  directory "app", force: true
  directory "config", force: true
  directory "db", force: true
  directory "test", force: true

  # initial layout views / partials with tailwind classes
  # tailwind default setup
  # model with validation for setting singleton
end

def setup_the_db
  rails_command "db:drop"
  rails_command "db:create"
  rails_command "db:migrate"
  rails_command "db:seed"
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
  add_static_pages
  add_settings

  copy_templates

  setup_the_db

  # Commit everything to git
  unless ENV["SKIP_GIT"]
    git :init
    git add: "."
    # git commit will fail if user.email is not configured
    begin
      git commit: %( -m 'Initial commit' )
    rescue StandardError => e
      puts e.message
    end
  end

  rails_command "test:all"

  say
  say "Spark app successfully created! Your tests should be green if everything was installed properly ; )", :green
  say
  say "Don't forget to move your new app to the correct directory on your local machine. Example: `mv ./#{original_app_name} ../ && cd ../#{original_app_name} && rails s`", :blue
  say
  say "# Update config/database.yml with your database credentials", :blue
  say
end

## TO DO
# Copy Stimulus files for toggling Tailwind UI menus
# Set up admin namespace
# Create heroku deploy environment for "production"
# Push to heroku and run rails db:seed on heroku / heroku restart etc.
