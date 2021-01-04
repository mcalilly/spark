# Use the correct version of Ruby
run "cp -f ../templates/.ruby-version ."

# Set up your gems
## app-wide
gem "clearance"
gem "pundit"
gem "friendly_id"
gem "aws-sdk-s3", require: false
gem "image_processing"

## groups
gem_group :test do
  gem "minitest-reporters"
  gem "guard"
  gem "guard-minitest"
  gem "launchy"
end

run "bundle install"

after_bundle do
  # Create the database
  rails_command "db:drop"
  rails_command "db:create"

  # Set up Stimulus
  rails_command "webpacker:install:stimulus"

  # Set up TailwindCSS
  run "yarn install"
  run "yarn add postcss@latest"
  run "yarn add tailwindcss@latest"
  run "yarn add @tailwindcss/forms"
  run "yarn add @tailwindcss/typography"
  run "yarn add @tailwindcss/aspect-ratio"
  run "yarn add alpinejs"

  ## Update Rails.root/postcss.config.js to match the template
  run "cp -rf ../templates/postcss.config.js ."

  ## add javascript/stylesheets folders
  run "mkdir app/javascript/stylesheets"
  run "mkdir app/javascript/stylesheets/components"

  ## add stylesheets/application.scss based on template
  run "cp ../templates/app/javascript/stylesheets/application.scss app/javascript/stylesheets"
  run "cp ../templates/app/javascript/stylesheets/components/shared.scss app/javascript/stylesheets/components"
  run "cp ../templates/app/javascript/stylesheets/tailwind.config.js app/javascript/stylesheets"

  ## Update the javscript/packs/application.js based on the template
  run "cp ../templates/app/javascript/packs/application.js app/javascript/packs"

  # Set up basic layouts
  run "cp -rf ../templates/app/views/shared app/views/shared"
  run "cp -f ../templates/app/views/layouts/public.html.erb app/views/layouts"
  run "cp -f ../templates/app/assets/images/logo.svg app/assets/images"
  run "cp -f ../templates/app/assets/images/favicon.svg app/assets/images"

  # Add page titles
  run "cp -rf ../templates/app/helpers/application_helper.rb app/helpers"

  # Create a static pages controller
  rails_command "generate controller StaticPages home --no-stylesheets"
  run "cp -f ../templates/app/controllers/static_pages_controller.rb app/controllers"
  run "cp -f ../templates/app/views/static_pages/home.html.erb app/views/static_pages"

  # Install Clearance
  rails_command "generate clearance:install"
  rails_command "db:migrate"
  generate :migration, "add_role_to_users", "role:integer"
  rails_command "db:migrate"

  run "cp -f ../templates/config/initializers/clearance.rb config/initializers"
  ## Copy a user model with validations
  run "cp -f ../templates/app/models/user.rb app/models"
  ## Copy custom Clearance views
  run "cp -rf ../templates/app/views/clearance_mailer app/views"
  run "cp -rf ../templates/app/views/passwords app/views"
  run "cp -rf ../templates/app/views/sessions app/views"
  run "cp -rf ../templates/app/views/users app/views"
  ## Copy environment configs that work with Clearance
  run "cp -f ../templates/config/environments/test.rb config/environments"
  run "cp -f ../templates/config/environments/development.rb config/environments"
  run "cp -f ../templates/config/environments/production.rb config/environments"

  # Set up a blog
  rails_command "generate scaffold post title:string body:text --no-stylesheets --no-test-framework"
  rails_command "db:migrate"
  rails_command "action_text:install"
  run "cp -f ../templates/app/models/post.rb app/models"
  run "cp -f ../templates/app/controllers/posts_controller.rb app/controllers"
  run "cp -rf ../templates/app/views/posts app/views"
  run "rm -f app/assets/stylesheets/application.css"
  run "cp -rf ../templates/app/assets/stylesheets app/assets"
  ## Add friendly urls to the blog
  generate :migration, "add_slug_to_posts", "slug:uniq"
  rails_command "generate friendly_id"
  rails_command "db:migrate"
  run "cp -f ../templates/app/models/post.rb app/models"
  run "cp -f ../templates/app/controllers/posts_controller.rb app/controllers"
  run "cp -rf ../templates/app/views/posts app/views"
  run "rm -f app/assets/stylesheets/application.css"
  run "cp -rf ../templates/app/assets/stylesheets app/assets"
  ## Add featured image to the blog
  rails_command "active_storage:install"
  rails_command "db:migrate"
  run "cp -rf ../templates/app/javascript/packs/components app/javascript/packs"
  ## Add description to the blog
  generate :migration, "add_description_to_posts", "description:text"

  # Create a settings scaffold
  rails_command "generate scaffold setting site_name:string site_description:text email:string tracking_codes:text twitter_handle:string facebook_handle:string instagram_handle:string street:string city:string state:string zip:string --no-stylesheets --no-test-framework"
  rails_command "db:migrate"
  run "cp -f ../templates/app/models/setting.rb app/models"
  run "cp -f ../templates/app/controllers/settings_controller.rb app/controllers"
  run "cp -rf ../templates/app/views/settings app/views"

  # Set up Pundit
  run "cp -f ../templates/app/controllers/application_controller.rb app/controllers"
  run "cp -rf ../templates/app/policies app"
  run "cp -f ../templates/config/locales/en.yml config/locales"

  # Set up admin layout
  run "cp -f ../templates/app/views/layouts/admin.html.erb app/views/layouts"
  run "cp -rf ../templates/app/views/shared/admin app/views/shared"

  # Update the routes file
  run "cp -f ../templates/config/routes.rb config"

  # Copy the tests
  run "cp -f ../templates/Guardfile ."
  run "cp -rf ../templates/test ."

  # Seed the db
  run "cp -f ../templates/db/seeds.rb db"

  # Add a Procfile for Heroku
  run "cp -f ../templates/Procfile ."

  # Seed the db
  rails_command "db:migrate"
  rails_command "db:seed"

  # Commit everything else
  run "git add -A"
  run "git commit -m 'Finish initial Rails setup with Spark'"

  # Need to add warnings to the homepage about mailer config, host config, etc.

  # Fire it up
  say
  say "You've successfully Spark-ed a new rails app!", :green
  say
  say "This Spark template was created to use Ruby 2.7.2, Rails 6.0.3.4, and Postgres, so if you have any trouble, make sure that you have all those installed and compatible with the versions of gems declared in your gemfile", :blue
end
