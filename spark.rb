require "fileutils"
require "shellwords"

# Copied from: https://github.com/excid3/jumpstart/blob/master/template.rb
# rails new your_app -m path/to/this/spark.rb
# also your ~/.railsrc should have --database=postgresql

def set_source_paths
  source_paths.unshift(File.dirname(__FILE__))
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
  # Add Application Name to Config
  environment "config.application_name = Rails.application.class.module_parent_name"

  # Announce the user where they can change the application name in the future.
  puts "You can change application name inside: ./config/application.rb"
end

def add_authentication
  generate "devise:install"
  generate "devise:views"
end

def add_authorization
  generate "pundit:install"
end

def add_css
  rails_command "tailwindcss:install"
end

def add_javascript
  # importmap-rails
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
  # scaffold for settings singleton
end

def add_tests
  # to do
end

def setup_the_db
  rails_command "db:create"
  rails_command "db:migrate"
  rails_command "db:seed"
end

# Main setup
set_source_paths
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
  add_tests

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

  say
  say "Spark app successfully created!", :blue
  say
  say "To get started with your new app:", :green
  say "  mv #{original_app_name} ../ && cd ../#{original_app_name} then run `rails s`"
  say
  say "  # Update config/database.yml with your database credentials"
  say
end

## TO DO
# Copy Stimulus files for toggling Tailwind UI menus
# Set up admin namespace
# Create heroku deploy environment for "production"
# Push to heroku and run rails db:seed on heroku / heroku restart etc.
