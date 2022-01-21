require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "home action works as the root path" do
    get root_url
    assert_response :success
  end

  test "about action works" do
    get about_url
    assert_response :success
  end

  test "contact action works" do
    get contact_url
    assert_response :success
  end

end
