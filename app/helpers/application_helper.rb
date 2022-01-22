module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = "")
    base_title = "It's a New Spark Website!"
    if page_title.empty?
      base_title + " • " + "Designed With Spark"
    else
      page_title + " • " + base_title
    end
  end

  # Returns the seo meta description on a per-page basis.
  def meta_description(page_meta_description = "")
    if page_meta_description.empty?
      "Another website built with Spark, which is like Wordpress, but if it were designed by the Ruby community."
    else
      page_meta_description
    end
  end

  # Returns the seo keywords on a per-page basis.
  def meta_keywords(page_meta_keywords = "")
    if page_meta_keywords.empty?
      "Spark CMS, content management system, ruby cms, ruby content management system, ruby on on rails cms"
    else
      page_meta_keywords
    end
  end

  # Returns the featured image for meta data on a per-page basis.
  def meta_image(page_meta_image = "")
    if page_meta_image.empty?
      nil
    else
      page_meta_image
    end
  end

  settings = Setting.last

  def site_title
    site_title = settings.site_title
  end

  def site_tagline
    site_tagline = settings.site_tagline
  end

  def site_description
    site_description = settings.site_description
  end

  def site_email
    site_email = settings.email
  end

  def facebook_handle
    facebook_handle = settings.twitter_handle
  end

  def twitter_handle
    twitter_handle = settings.twitter_handle
  end

  def instagram_handle
    instagram_handle = settings.instagram_handle
  end
end
