# Spark Rails Application Template

Spark is like the Wordpress famous 5-minute install, but for Rails. With Rails 7 and tools like Active Storage, Action Text, and Hotwire, it's now just as easy to model content and deploy to Heroku or Render as it is to work with a CMS like Wordpress. It's also way more convenient to have your database right there instead of modeling content in a headless CMS like Contentful or Prismic, which you then have to pull across the internet and display via a static site generator.

The goal of this script is to automate all of the repetitive stuff needed to set up a new brochure-style site and use Rails to create a custom CMS. Things like authentication and an admin namespace come out of the box, and it can be easily extended with generators for common features like a blog.

Starting with Spark is just as easy as installing any CMS, but it comes with the added flexibility and power of Rails. For most websites, 80% of what you need can be automated with a Rails generator and then re-used as needed on any new project (things like a blog, static pages, and so on). This gives you the convenience of not having to start from scratch every time you need to manage some content, along with the flexibility to extend your site as needed because it's just a trusty 'ole Rails app.

## Creating a new app
Create from github:
* `rails new your_app -d postgresql -m https://raw.githubusercontent.com/mcalilly/spark/main/template.rb --css tailwind`

Or if you've downloaded this repo locally:
* `rails new your_app -d postgresql -m template.rb --css tailwind`
