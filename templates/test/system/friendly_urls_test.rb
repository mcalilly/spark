require 'application_system_test_case'

class FriendlyUrlsTest < ApplicationSystemTestCase

  setup do
    @post = posts(:welcome)
  end

  test "/ should be url for the home page" do
    assert root_path == "/"
  end

  test "posts should have a friendly url" do
    visit posts_path
    click_on @post.title
    # make sure Friendly_ID is building the url with correct slug
    assert_current_path post_path(Post.friendly.find(@post.id))
    assert_equal @post.slug, Post.friendly.find(@post.id).slug
  end

end
