require "application_system_test_case"

class NewsClipsTest < ApplicationSystemTestCase
  setup do
    @news_clip = news_clips(:nytimes_article)
    @admin = users(:admin)
    @non_admin = users(:member)
  end

  test "visiting the index should be accessible to everyone" do
    visit news_clips_path
    assert_current_path news_clips_path
    assert_text "In the News"
    sign_in @non_admin
    visit news_clips_path
    assert_current_path news_clips_path
    assert_text "In the News"
    sign_in @admin
    visit news_clips_path
    assert_current_path news_clips_path
    assert_text "In the News"
  end

  test "viewing show page should be accessible to everyone" do
    visit news_clip_path(@news_clip)
    assert_current_path news_clip_path(@news_clip)
    assert_selector "h1", text: @news_clip.headline
    sign_in @non_admin
    visit news_clip_path(@news_clip)
    assert_current_path news_clip_path(@news_clip)
    assert_selector "h1", text: @news_clip.headline
    sign_in @admin
    visit news_clip_path(@news_clip)
    assert_current_path news_clip_path(@news_clip)
    assert_selector "h1", text: @news_clip.headline
  end

end
