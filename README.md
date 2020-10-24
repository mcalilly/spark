# Spark - A CMS built on Rails
Spark is a content management system ("CMS") that's just a big-ass script (aka [Rails Application Template](https://guides.rubyonrails.org/rails_application_templates.html)) that automates all of the stuff you need on most websites. It's inspired by the the Wordpress "famous 5 minute install."

## Background
While working on a recent project I had to copy/paste a bunch of configuration to use Prismic CMS in my Rails app, which prompted me to start looking into Rails Application Templates. It dawned on me that running Rails App Template script that generates that most basic sites need—like a blog—is essentially how the Wordpress install works.

My next thought?

Why not automate it and just call the database instead of the Prismic API? If most of the stuff I use a CMS for is already built, then I'd rather use Rails instead of some sort of headless CMS like Prismic to build custom features.

If I made my Rails Application Template robust enough, wouldn't this essentially be just like Wordpress, but with Ruby instead of PHP?

## YACMS (Yet Another Content Management System)
I've used every CMS in the book going back to the mid-aughts —> Wordpress, Expression Engine, Drupal, Shopify, Refinery, Squarespace, custom builds, and now the new crop of headless API-centric like Prismic and Contentful.

While I think a CMS-as-API is the best option to date, what I've found is that those offer TOO much customization because they have to be flexible enough to model any type of content.

But, developers don't actually want to re-implement how the user adds their Google Analytics code on every new site. Why not pick a great convention for how a blog works?

For end users, a headless CMS like Prismic is better than something like Wordpress because the developers can easily model the content to fit their unique needs, but because these headless CMS's need to be flexible enough to handle _any_ type of content it inevitably passes on unnecessary complexity to the content editor, who is usually not technically savvy.

So, the goal of this project is to use the best ideas from all of those CMS's that came before, make some good decisions about features every site needs, and automate setting up and deploying the features that every website needs. The old [omakase approach](https://dhh.dk/2012/rails-is-omakase.html).

If your users need custom features, then you're in business because it's just a Rails app with the crap you don't want to have to build already made for you.

## I'd love you to join me
I started this project to make the CMS I want to use. I know, I know, yet another CMS. But I think there's still room to do it better.

If you'd like to see some of the options on the omakase menu change, please show me how to do it better! Fork it and submit a pull request. Let's do this.

Let's bring back the weird, wild web.

- [Lee McAlilly](https://mcalilly.com)
