# Spark Rails Application Template

Like the Wordpress famous 5-minute install, but for Rails. With Rails 7 and tools like Active Storage, Action Text, and Hotwire, it's now just as easy to model content and deploy to Heroku or Render as it is to customize Wordpress or model content in a headless CMS like Contentful or Prismic and then gather that content into a static site generator.

By modeling content directly in a database with trusty old Rails, you don't have to call your content over the web, the database it right there. The goal of this script is to automate all of the repetitive stuff needed to set up a new brochure-style site such as authentication and an admin namespace, and then create generators for common features like a blog.

Starting with Spark can be just as easy as installing any CMS, but with added flexibility and power of Rails. For most websites, 80% of what you need can be automated with a Rails generator and then re-used as needed on any new project (things like a blog, static pages, etc.) This gives you the convenience of using a CMS with the flexibility of a custom rails app.


## Creating a new app
Create from github:
* `rails new your_app -d postgresql -m https://raw.githubusercontent.com/mcalilly/spark/main/template.rb --css tailwind`

Or if you've downloaded this repo locally:
* `rails new your_app -d postgresql -m template.rb --css tailwind`
