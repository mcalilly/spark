require "application_system_test_case"

class AdminNewsClipsTest < ApplicationSystemTestCase
  setup do
    @news_clip = news_clips(:nytimes_article)
    @admin = users(:admin)
    @non_admin = users(:member)
  end

  test "non-admins should not be able to view, create, edit, or delete" do
    # first test the general public
    visit new_admin_news_clip_path
    assert_text "Sign in to your account"
    visit edit_admin_news_clip_path(@news_clip)
    assert_text "Sign in to your account"
    visit admin_news_clip_path(@news_clip)
    assert_text "Sign in to your account"
    visit admin_news_clips_path
    assert_text "Sign in to your account"

    # Then test as a non admin
    sign_in @non_admin
    visit new_admin_news_clip_path
    assert_text "You don't have permission to update news clips."

    visit edit_admin_news_clip_path(@news_clip)
    assert_text "You don't have permission to update news clips."

    visit admin_news_clip_path(@news_clip)
    assert_no_selector "h1", text: "News"
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"

    visit admin_news_clip_path(@news_clip)
    assert_no_selector "h1", text: "News"
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"
  end

  test "admins can create a news clip" do
    sign_in @admin
    visit admin_news_clips_path
    click_on "Add a News Clip"
    fill_in "news_clip[publication]", with: "New York Times"
    fill_in "news_clip[headline]", with: "It's a New News Clip"
    fill_in "news_clip[publication_date]", with: Date.today
    click_button "Save"
    assert_text "It's a New News Clip"
  end

  test "admins should be able to edit a news clip" do
    sign_in @admin
    visit admin_news_clip_path(@news_clip)
    find_link("Edit", match: :first).click
    fill_in "news_clip[headline]", with: "We've Edited This Headline"
    click_button "Save"
    assert_text "We've Edited This Headline"
  end

  test "only admins can delete news clips" do
    visit admin_news_clip_path(@news_clip)
    assert_no_text "Delete"
    assert_text "You need to sign in"

    sign_in @non_admin
    visit admin_news_clip_path(@news_clip)
    assert_no_text "Delete"

    sign_in @admin
    visit admin_news_clip_path(@news_clip)
    page.accept_confirm do
      click_link "Delete", match: :first
    end
    assert_text "This news clip has been deleted."
  end
end
