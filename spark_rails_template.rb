# Set up your gems
## app-wide
gem "clearance"
gem "pundit"

## groups
gem_group :test do
  gem "minitest-reporters"
  gem "guard"
  gem "guard-minitest"
  gem "launchy"
end

run "bundle install"

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
  run "cp ~/Code/spark/app/javascript/stylesheets/application.scss app/javascript/stylesheets"
  run "cp ~/Code/spark/app/javascript/stylesheets/components/shared.scss app/javascript/stylesheets/components"
  run "cp ~/Code/spark/app/javascript/stylesheets/tailwind.config.js app/javascript/stylesheets"

  ## Update Rails.root/postcss.config.js to match the template
  run "cp -f ~/Code/spark/postcss.config.js ."

  ## Update the javscript/packs/application.js based on the template
  run "cp ~/Code/spark/app/javascript/packs/application.js app/javascript/packs"

  # Set up basic layouts
  run "cp -rf ~/Code/spark/app/views/shared app/views/shared"
  run "cp -f ~/Code/spark/app/views/layouts/application.html.erb app/views/layouts"

  # Add page titles
  run "cp -rf ~/Code/spark/app/helpers/application_helper.rb app/helpers"

  # Create a static pages controller
  rails_command "generate controller StaticPages home --no-stylesheets"
  run "cp -f ~/Code/spark/app/controllers/static_pages_controller.rb app/controllers"
  run "cp -f ~/Code/spark/app/views/static_pages/home.html.erb app/views/static_pages"

  # Install Clearance
  rails_command "generate clearance:install"
  rails_command "db:migrate"
  generate :migration, "add_role_to_users", "role:integer"
  rails_command "db:migrate"

  run "cp -f ~/Code/spark/config/initializers/clearance.rb config/initializers"
  ## Copy a user model with validations
  run "cp -f ~/Code/spark/app/models/user.rb app/models"
  ## Copy custom Clearance views
  run "cp -rf ~/Code/spark/app/views/clearance_mailer app/views"
  run "cp -rf ~/Code/spark/app/views/passwords app/views"
  run "cp -rf ~/Code/spark/app/views/sessions app/views"
  run "cp -rf ~/Code/spark/app/views/users app/views"
  ## Copy environment configs that work with Clearance
  run "cp -f ~/Code/spark/config/environments/development.rb config/environments"
  run "cp -f ~/Code/spark/config/environments/production.rb config/environments"
  run "cp -f ~/Code/spark/config/environments/test.rb config/environments"

  # Create a settings scaffold
  ## in the views, if nil it goes to Spark defaults, if present, then pulls from the database settings. This would be for something like reply-to email

  # Set up tests
  run "cp -f ~/Code/spark/Guardfile ."
  run "cp -f ~/Code/spark/test/test_helper.rb test"
  run "cp -f ~/Code/spark/test/application_system_test_case.rb test"

  # Copy initial tests
  run "cp -f ~/Code/spark/test/controllers/static_pages_controller_test.rb test/controllers"
  run "cp -f ~/Code/spark/test/controllers/users_controller_test.rb test/controllers"
  # run "cp -rf ~/Code/spark/test/fixtures/action_text test/fixtures"
  # run "cp ~/Code/spark/test/fixtures/files/example-featured-image.png test/fixtures/files"
  # run "cp ~/Code/spark/test/fixtures/blog_posts.yml test/fixtures"
  run "cp ~/Code/spark/test/fixtures/users.yml test/fixtures"
  run "cp ~/Code/spark/test/mailers/password_reset_mailer_test.rb test/mailers"
  # run "cp ~/Code/spark/test/models/blog_post_test.rb test/models"
  run "cp ~/Code/spark/test/models/user_test.rb test/models"
  # run "cp ~/Code/spark/test/system/blog_posts_test.rb test/system"
  run "cp ~/Code/spark/test/system/friendly_urls_test.rb test/system"
  run "cp ~/Code/spark/test/system/static_pages_test.rb test/system"
  run "cp ~/Code/spark/test/system/user_password_reset_test.rb test/system"
  run "cp ~/Code/spark/test/system/user_sign_in_test.rb test/system"
  run "cp ~/Code/spark/test/system/user_sign_out_test.rb test/system"
  run "cp ~/Code/spark/test/system/user_sign_up_test.rb test/system"

  # Set up a blog
  rails_command "generate scaffold post title:string body:text --no-stylesheets --no-test-framework"
  rails_command "db:migrate"
  run "cp -f ~/Code/spark/test/controllers/posts_controller_test.rb test/controllers"
  rails_command "action_text:install"
  run "cp -f ~/Code/spark/app/models/post.rb app/models"
  run "cp -rf ~/Code/spark/app/views/posts app/views"
  run "rm -f app/assets/stylesheets/application.css"
  run "cp -rf ~/Code/spark/app/assets/stylesheets app/assets"
  run "cp -f ~/Code/spark/test/fixtures/posts.yml test/fixtures"
  run "cp -f ~/Code/spark/test/models/post_test.rb test/models"
  run "cp -f ~/Code/spark/test/system/posts_test.rb test/system"

  # Set up Pundit
  run "cp -f ~/Code/spark/app/controllers/application_controller.rb app/controllers"
  run "cp -f ~/Code/spark/app/controllers/posts_controller.rb app/controllers"
  run "cp -rf ~/Code/spark/app/policies app"
  run "cp -f ~/Code/spark/config/locales/en.yml config/locales"

  # Update the routes file
  run "cp -f ~/Code/spark/config/routes.rb config"

  # Seed the db
  run "cp -f ~/Code/spark/db/seeds.rb db"

  # Add a Procfile for Heroku
  run "cp -f ~/Code/spark/Procfile ."

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
  say "This Spark template was created to use Ruby 2.7.1, Rails 6.0.3.4, and Postgres, so if you have any trouble, make sure that you have all those installed and they are listed along with the 'pg' gem in your gemfile.", :blue
end
