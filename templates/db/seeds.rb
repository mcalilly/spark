# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create!(
  email: "kermit@example.com",
  password: "staygreen",
  role: "guest"
)

User.create!(
  email: "elvis@example.com",
  password: "bacon",
  role: "admin"
)

# Site Settings
Setting.create!(
  email: "hi@designwithspark.com",
  site_name: "Spark CMS",
  site_description: "A wonderful new CMS built for Rails.",
  tracking_codes: "Replace this with any tracking codes you'd like to use. Google Analytics, etc.",
  twitter_handle: "ssparkcmss",
  facebook_handle: "sparkcms",
  instagram_handle: "spark_cms",
  street: "1600 Pennsylvania Avenue NW",
  city: "Washington",
  state: "DC",
  zip: "20500"
)

# Blog posts
Post.create!(
  title: "Welcome to a New Site Designed With Spark",
  body: "Look, just because I don't be givin' no man a foot massage don't make it right for Marsellus to throw Antwone into a glass motherfuckin' house, fuckin' up the way the nigger talks. Motherfucker do that shit to me, he better paralyze my ass, 'cause I'll kill the motherfucker, know what I'm sayin'?",
  description: "The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men."
)

Post.create!(
  title: "A Second Blog Post",
  body: "Do you see any Teletubbies in here? Do you see a slender plastic tag clipped to my shirt with my name printed on it? Do you see a little Asian child with a blank expression on his face sitting outside on a mechanical helicopter that shakes when you put quarters in it? No? Well, that's what you see at a toy store. And you must think you're in a toy store, because you're here shopping for an infant named Jeb.",
  description: "Now that we know who you are, I know who I am. I'm not a mistake! It all makes sense! In a comic, you know how you can tell who the arch-villain's going to be? "
)
