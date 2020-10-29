require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:elvis)
    @post = posts(:welcome)
  end

  test "should get index" do
    get posts_path(as: @admin)
    assert_response :success
  end

  test "should get new" do
    get new_post_path(as: @admin)
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_path(as: @admin), params: { post: { title: "A unique title" } }
    end

    assert_redirected_to post_path(Post.last)
  end

  test "should show post" do
    get post_path(@post, as: @admin)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_path(@post, as: @admin)
    assert_response :success
  end

  test "should update post" do
    patch post_path(@post, as: @admin), params: { post: { title: "A new title" } }
    assert_redirected_to post_path(Post.friendly.find('a-new-title'))
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_path(@post, as: @admin)
    end

    assert_redirected_to posts_path
  end
end
