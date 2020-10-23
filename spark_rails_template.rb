# Set up your gems
## app-wide
gem "clearance"

## groups
gem_group :development do
  gem "guard", "~> 2.14", require: false
  gem "guard-minitest", "~> 2.4", require: false
end

gem_group :test do
  gem "minitest-reporters"
  gem "guard"
  gem "guard-minitest"
  gem "launchy"
end

# Create the database
rails_command "db:create"

after_bundle do
  # Set up Stimulus
  rails_command "webpacker:install:stimulus"

  # Set up TailwindCSS
  run "yarn add tailwindcss@latest"
  run "yarn add @tailwindcss/ui"
  run "yarn add alpinejs"

  ## add javascript/stylesheets folders
  run "mkdir app/javascript/stylesheets"
  run "mkdir app/javascript/stylesheets/components"

  ## add stylesheets/application.scss based on template
  run "cp ~/Code/spark/javascript/stylesheets/application.scss app/javascript/stylesheets"
  run "cp ~/Code/spark/javascript/stylesheets/components/shared.scss app/javascript/stylesheets/components"
  run "cp ~/Code/spark/javascript/stylesheets/tailwind.config.js app/javascript/stylesheets"

  ## Update Rails.root/postcss.config.js to match the template
  run "cp -f ~/Code/spark/postcss.config.js ."

  ## Update the javscript/packs/application.js based on the template
  run "cp ~/Code/spark/javascript/packs/application.js app/javascript/packs"

  # Set up basic layouts
  run "cp -rf ~/Code/spark/views/shared app/views/shared"
  run "cp -f ~/Code/spark/views/layouts/application.html.erb app/views/layouts"

  # Add page titles
  run "cp -rf ~/Code/spark/helpers/application_helper.rb app/helpers"

  # Create a static pages controller
  rails_command "generate controller StaticPages home --no-stylesheets"
  run "cp -f ~/Code/spark/views/static_pages/home.html.erb app/views/static_pages"

  # Install Clearance
  rails_command "generate clearance:install"
  rails_command "db:migrate"
  run "cp -f ~/Code/spark/config/initializers/clearance.rb config/initializers"
  rails_command "generate clearance:views"

  # Set up tests

  # Set up pundit

  # Add Rubocop

  # Set up a blog

  # Create a settings scaffold
  ## in the views, if nil it goes to Spark defaults, if present, then pulls from the database settings. This would be for something like reply-to email

  # TO DO
  # - Add questions to configure things like admin email address, domain name, etc. These can be used to
  # - What would you like to call your blog ? (blog, news, updates, announcements?)

  # - Copy Test config files

  # Update the routes file
  run "cp -f ~/Code/spark/config/routes.rb config"

  # Commit everything else
  run "git add -A"
  run "git commit -m 'Finish initial Rails setup with Spark'"

  # Fire it up
  say
  say "You've successfully Spark-ed a new rails app!", :green
  say
  say "This Spark template was created to use Ruby 2.7.1, Rails 6.0.3.4, and Postgres, so if you have any trouble, make sure that you have all those installed and they are listed along with the 'pg' gem in your gemfile.", :blue
end
