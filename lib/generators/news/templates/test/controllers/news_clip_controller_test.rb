require "test_helper"

class NewsClipControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @non_admin = users(:member)
    @news_clip = news_clips(:nytimes_article)
  end

  test "should get index" do
    # public can view
    get news_clips_url
    assert_response :success

    # non-admins can view
    sign_in @non_admin
    get news_clips_url
    assert_response :success

    # admins can view
    sign_in @admin
    get news_clips_url
    assert_response :success
  end

  test "should show a news clip" do
    # public can view
    get news_clip_url(@news_clip)
    assert_response :success

    # contributors can view
    sign_in @non_admin
    get news_clip_url(@news_clip)
    assert_response :success

    # admins can view
    sign_in @admin
    get news_clip_url(@news_clip)
    assert_response :success
  end

end
