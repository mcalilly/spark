require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:welcome)
    @admin = users(:kermit)
    @non_admin = users(:elvis)
  end

  test "visiting the index should be accessible to all" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "viewing a post should be accessible to all" do
    visit posts_url
    click_on @post.title
    assert_current_path post_path(@post)
    assert_selector "h1", text: @post.title.titleize
  end

  test "non-admins should not be able to create, edit, or delete" do
    visit posts_url(as: @non_admin)
    click_on "New Post"
    within(".flash") do
      assert_text "You cannot perform this action."
    end

    visit posts_url(as: @non_admin)
    click_on "Edit", match: :first
    within(".flash") do
      assert_text "You cannot perform this action."
    end

    visit posts_url(as: @non_admin)
    click_on "Show", match: :first
    assert_selector "a", text: "Delete", count: 0
  end

  test "creating an Post" do
    visit posts_url(as: @admin)
    click_on "New Post"
    fill_in "Title", with: @post.title
    find(:css, ".trix-content").set("This is the body of the post.")
    click_button "Create Post"
    within(".flash") do
      assert_text "Post was successfully created"
    end

    click_on "Back"
  end

  test "updating an Post" do
    visit posts_url(as: @admin)
    click_on "Edit", match: :first

    fill_in "Title", with: @post.title
    click_button "Update Post"

    within(".flash") do
      assert_text "Post was successfully updated"
    end
    click_on "Back"
  end

  test "destroying an Post" do
    visit posts_url(as: @admin)
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    within(".flash") do
      assert_text "Post was successfully destroyed"
    end
  end
end
