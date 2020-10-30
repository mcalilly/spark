require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:welcome)
    @admin = users(:elvis)
    @non_admin = users(:kermit)
  end

  test "visiting the index should be accessible to all" do
    visit posts_path
    assert_selector "h1", text: "Posts"
  end

  test "viewing a post should be accessible to all" do
    visit posts_path
    click_on @post.title
    assert_current_path post_path(@post)
    assert_selector "h1", text: @post.title.titleize
  end

  test "non-admins should not be able to create, edit, or delete" do
    visit posts_path(as: @non_admin)
    click_on "New Post"
    within(".flash") do
      assert_text "You cannot perform this action."
    end

    visit posts_path(as: @non_admin)
    click_on "Edit", match: :first
    within(".flash") do
      assert_text "You cannot perform this action."
    end

    visit posts_path(as: @non_admin)
    click_on "Show", match: :first
    assert_selector "a", text: "Delete", count: 0
  end

  test "creating a Post" do
    visit posts_path(as: @admin)
    click_on "New Post"
    fill_in "Title", with: "Another Unique Title"
    find(:css, ".trix-content").set("This is the body of the post.")
    attach_file("post[featured_image]", "#{Rails.root.join("test/fixtures/files/example-featured-image.jpg")}")
    click_button "Create Post"
    sleep 0.5

    within(".flash") do
      assert_text "Post was successfully created"
    end

    click_on "Back"
  end

  test "updating a Post" do
    visit posts_path(as: @admin)
    click_on "Edit", match: :first

    fill_in "Title", with: @post.title
    click_button "Update Post"

    within(".flash") do
      assert_text "Post was successfully updated"
    end
    click_on "Back"
  end

  test "destroying a Post" do
    visit posts_path(as: @admin)
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    within(".flash") do
      assert_text "Post was successfully destroyed"
    end
  end
end
