# Spark - A CMS built on Rails
Spark is a content management system (aka "CMS") that's just a big-ass script (aka [Rails Application Template](https://guides.rubyonrails.org/rails_application_templates.html)) that automates all of the stuff that you need to do on every site. It's inspired by the the Wordpress "famous 5 minute install."

While working on a recent project where I had to copy/paste a bunch of configuration to use Prismic CMS in my Rails app, I started looking into Rails Application Templates. It dawned on me that a Rails App Template that setups up most of the stuff that most basic sites need is essentially how Wordpress works.

My next thought?

I wish I could redesign Wordpress, but have it be Ruby instead of PHP, and also have the power of Rails behind it if I need to add custom features. (I'd much prefer building custom stuff in Rails than doing something like creating a Wordpress plugin or Shopify App.)

Voila! The idea for a new CMS was born. Spark is like Wordpress (with better design choices), but for Rails. Convention over configuration, yada yada yada. For instance, there's only one way I want a blog to work in 2020. As that "way" changes, we can evolve, but this is not a CMS for people that want too many options.

## Background
I've used every CMS in the book going back to 2008—Wordpress, Expression Engine, Drupal, Shopify, Refinery Squarespace, custom builds, and now the new crop of headless API-centric like Prismic and Contentful.

While I think CMS-as-API is the best option to date, what I've found is that those offer TOO much customization. The options are limitless. Developers don't actually want to re-implement how the user adds their Google Analytics code on every new site. For end users, a headless CMS like Prismic is better than something like Wordpress because the developers can easily model content for their unique needs, but the problem is these are built to be flexible enough to handle _any_ type of content and that inevitably passes on unnecessary complexity to the content editor, who is often not technically savvy.

The goal of this project is to use the best ideas from all of those CMS's that came before and make some good decisions that simplify the 80% of stuff that every site needs. The old [omakase approach](https://dhh.dk/2012/rails-is-omakase.html).

If your users need custom features, then you're in business because it's just a Rails app with the crap you don't want to have to build already made for you.

## I'd love you to join me
I started this project to make the CMS I want to use. I know, I know, yet another CMS. But I think there's still room to do it better.

If you'd like to see some of the options on the omakase menu change, please show me how to do it better! Fork it and submit a pull request. Let's do this.

- [Lee McAlilly](https://mcalilly.com)
Let's bring back the weird, wild web.
