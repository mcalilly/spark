require "test_helper"

class IssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @non_admin = users(:member)
    @issue = issues(:climate)
  end

  test "should get index" do
    # public can view
    get issues_url
    assert_response :success

    # non-admins can view
    sign_in @non_admin
    get issues_url
    assert_response :success

    # admins can view
    sign_in @admin
    get issues_url
    assert_response :success
  end

  test "should show an issue" do
    # public can view
    get issue_url(@issue)
    assert_response :success

    # check friendly url
    get issue_url(Issue.friendly.find('climate-change'))
    assert_response :success

    # contributors can view
    sign_in @non_admin
    get issue_url(@issue)
    assert_response :success

    # admins can view
    sign_in @admin
    get issue_url(@issue)
    assert_response :success
  end

end
