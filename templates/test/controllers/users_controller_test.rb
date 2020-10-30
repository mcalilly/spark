require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get /sign-up as the sign up page" do
    get sign_up_path
    assert_response :success
  end

  test "should get /sign-in as the sign in page" do
    get sign_in_path
    assert_response :success
  end

  test "should get /passwords/new as the password reset page" do
    get new_password_path
    assert_response :success
  end

end
