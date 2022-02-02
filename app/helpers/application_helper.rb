module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = "")
    if page_title.empty?
      site_title + " • " + site_tagline
    else
      page_title + " • " + site_title
    end
  end

  # Returns the seo meta description on a per-page basis.
  def meta_description(page_meta_description = "")
    if page_meta_description.empty?
      site_description
    else
      page_meta_description
    end
  end

  # Returns the seo keywords on a per-page basis.
  def meta_keywords(page_meta_keywords = "")
    if page_meta_keywords.empty?
      site_title
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

  def site_title
    site_title = Setting.last.site_title
  end

  def site_tagline
    site_tagline = Setting.last.site_tagline
  end

  def site_description
    site_description = Setting.last.site_description
  end

  def site_logo
    if Setting.last.logo
      site_logo = Setting.last.logo
    end
  end

  def site_email
    site_email = Setting.last.email
  end

  def facebook_handle
    facebook_handle = Setting.last.facebook_handle
  end

  def twitter_handle
    twitter_handle = Setting.last.twitter_handle
  end

  def instagram_handle
    instagram_handle = Setting.last.instagram_handle
  end
end
