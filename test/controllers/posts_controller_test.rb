require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:kermit)
    @post = posts(:welcome)
  end

  test "should get index" do
    get posts_url(as: @admin)
    assert_response :success
  end

  test "should get new" do
    get new_post_url(as: @admin)
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url(as: @admin), params: { post: { title: @post.title } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post, as: @admin)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post, as: @admin)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post, as: @admin), params: { post: { title: @post.title } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post, as: @admin)
    end

    assert_redirected_to posts_url
  end
end
