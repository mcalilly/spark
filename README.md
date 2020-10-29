# Spark - A CMS built on Rails
Spark is a "content management system" that's really just a big-ass script that automates building all of the stuff in Rails that you need on most websites. It uses a [Rails Application Template](https://guides.rubyonrails.org/rails_application_templates.html) inspired by the Wordpress ["famous 5 minute install](https://wordpress.org/support/article/how-to-install-wordpress/)." Eventually we'll extract most of Spark's features into gems and have the script add them to your gemfile, but for now, it's just a big-ass script.

## How to Get Started
1. Download Spark:

`git clone https://github.com/mcalilly/spark.git`

2. Change into the spark directory you just downloaded:

`cd spark`

3. Create a new Spark Rails from inside the `/spark` directory:

`rails new your_app_name --database=postgresql --template=spark.rb`.

Alternatively, you could simply run `rails new your_app_name` if you add a `.railsrc` dot file to your home directory similar to [this](https://github.com/mcalilly/spark/blob/master/example-railsrc).

4. Move your new app from the spark directory to wherever you keep your code. It will be something like this:

`mv your_app_name ~/Code`

5. Now, navigate back into your new app directory. Something like this:

`cd ~/Code/your_app_name`

6. Start the server in a new terminal window at localhost:3000:

`rails s`

7. Make sure the tests are passing and run them as you go with Guard in another terminal window:

`bundle exec guard` (Hit `enter / return` to run them all at once.)

8. [Let us know](https://github.com/mcalilly/spark/issues) if you find bugs, or better yet, fork this thing and help us make it better!

## Background
Recently, while working on a new site I had to copy/paste [a bunch of files](https://github.com/mcalilly/prismic) from a previous project, so I started looking into automating this with Rails Application Templates. It dawned on me that if you used a Rails App Template to generate most of the features your new site would need, you could essentially "build" a CMS the same way the Wordpress install script does.

## YACMS (Yet Another Content Management System)
Since I started building websites in 2008, I've used every CMS in the book: Wordpress, Expression Engine, Moveable Type, Drupal, Shopify, Refinery, Squarespace, custom Rails apps, and most-recently the new headless/API-first options like Prismic and Contentful. Why make another one?

## What If We Could Have Wordpress, but With Ruby?
Enter Spark. It's like Wordpress, but built for Rails, so it's a great starting point for most of what every site needs backed by the power of Rails when you're ready to start building what makes your project unique.

The goal of Spark is to use the best ideas from all of the CMS's that came before, make some good decisions about features every site needs, and automate setting up and deploying these baseline features. It's the old [omakase approach](https://dhh.dk/2012/rails-is-omakase.html).

If your users need custom features, then you're in business because it's just a Rails app with the crap you don't want to have to build already made for you.

### The Problem for Developers
While I think the new headless CMS options are the best to date, what I've found is that those offer TOO much customization options and abstraction because they have to be flexible enough to model any type of content. I also have had to spend a lot of development time copying/pasting JSON files from one project to the next to [model content in the CMS](https://prismic.io/concepts/content-modeling) before I could even put that content into something useful like Gatsby or Rails.

Once you've done all that work modeling content in a CMS, it's not that much extra effort to just pull an object from the database in Rails rather than to fetch an object from an API. So why not just build a fresh, custom rails app, but do so in a Wordpressy way, where the decisions for most of what you need are automated for you out of the box?

### The Problem for Editors
For content editors, a headless CMS like Prismic is better than something like Wordpress because the developers can easily model the content to fit their unique needs, but because these headless CMS's need to be flexible enough to handle _any_ type of content it inevitably passes on unnecessary complexity to the editor, who is usually not technically savvy. Meanwhile, the developers find themselves building the same types of content models (blogs, pages, etc.) and don't want to have to repeat themselves on every new project.

## I'd love you to join me
I started this project to make the CMS I want to use. I know, I know, yet another CMS. But I think there's still room to do it better.

If you'd like to see some of the options on the omakase menu change, please show me how to do it better! Fork it and submit a pull request. Let's do this.

Let's bring back the weird, wild web.

Best,
[Lee McAlilly](https://mcalilly.com)
