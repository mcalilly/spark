require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:welcome)
    @admin = users(:elvis)
    @non_admin = users(:kermit)
  end

  test "visiting the index should be accessible to all" do
    visit posts_path
    assert_selector "h1", text: "Blog"
  end

  test "viewing a post should be accessible to all" do
    visit posts_path
    click_on @post.title
    assert_current_path post_path(@post)
    assert_selector "h1", text: @post.title.titleize
  end

  test "non-admins should not be able to create, edit, or delete" do
    visit posts_path(as: @non_admin)
    assert_no_selector "a", text: "New Post"

    visit new_post_path(as: @non_admin)
    within(".flash") do
      assert_text "You cannot perform this action."
    end

    visit posts_path(as: @non_admin)
    click_on @post.title
    assert_no_selector "a", text: "Edit"
    visit edit_post_path(@post)
    within(".flash") do
      assert_text "You cannot perform this action."
    end

    visit posts_path(as: @non_admin)
    click_on @post.title
    assert_no_selector "a", text: "Delete"
  end

  test "creating a Post" do
    visit posts_path(as: @admin)
    click_on "New Post"
    within("form") do
      fill_in "Title", with: "Another Unique Title"
      find(:css, "trix-editor").set("This is the body of the post.")
      attach_file("post[featured_image]", "#{Rails.root.join("test/fixtures/files/example-featured-image.jpg")}")
      fill_in "Description", with: "A new description for a new post."
      click_button "Save"
    end
    sleep 0.5

    within(".flash") do
      assert_text "Post was successfully created"
    end
  end

  test "updating a Post" do
    visit posts_path(as: @admin)
    click_on @post.title
    click_on "Edit"
    fill_in "Title", with: "A new unique title"
    click_button "Save"

    within(".flash") do
      assert_text "Post was successfully updated"
    end
  end

  test "deleting a Post" do
    visit post_path(@post, as: @admin)
    page.accept_confirm do
      click_on "Delete", match: :first
    end

    within(".flash") do
      assert_text "Post was successfully destroyed"
    end
  end
end
