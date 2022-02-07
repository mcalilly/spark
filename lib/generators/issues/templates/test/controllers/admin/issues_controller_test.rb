require "test_helper"

class AdminIssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @non_admin = users(:member)
    @issue = issues(:climate)
  end

  test "should get new" do
    # public cannot do this
    get new_admin_issue_url
    assert_response :redirect

    # contributors cannot do this
    sign_in @non_admin
    get new_admin_issue_url
    assert_response :redirect

    # admins can view
    sign_in @admin
    get new_admin_issue_url
    assert_response :success
  end

  test "should create an issue" do
    # public cannot do this
    assert_no_difference('Issue.count') do
      post admin_issues_url, params: { issue: { title: "Civil Rights", body: "A fundamental human right." } }
    end
    assert_response :redirect

    # contributors cannot do this
    sign_in @non_admin
    assert_no_difference('Issue.count') do
      post admin_issues_url, params: { issue: { title: "Civil Rights", body: "A fundamental human right." } }
    end
    assert_response :redirect

    # admins can create
    sign_in @admin
    assert_difference('Issue.count') do
      post admin_issues_url, params: { issue: { title: "Civil Rights", body: "A fundamental human right." } }
    end
    assert_response :redirect
  end

  test "should get edit" do
    # public cannot do this
    get edit_admin_issue_url(@issue)
    assert_response :redirect

    # contributors cannot do this
    sign_in @non_admin
    get edit_admin_issue_url(@issue)
    assert_response :redirect

    # admins can edit
    sign_in @admin
    get edit_admin_issue_url(@issue)
    assert_response :success
  end

  test "should update an issue" do
    # public cannot do this
    patch admin_issue_url(@issue), params: { issue: { title: "A Revised Issue Title" } }
    assert_response :redirect
    refute_match("A Revised Issue Title", @issue.title)

    # contributors cannot do this
    sign_in @non_admin
    patch admin_issue_url(@issue), params: { issue: { title: "A Revised Issue Title" } }
    assert_response :redirect
    refute_match("A Revised Issue Title", @issue.title)

    # only admins can do this
    sign_in @admin
    patch admin_issue_url(@issue), params: { issue: { title: "Another Admin Revised Issue Title", body: "revised body" } }
    assert_redirected_to admin_issue_url(@issue)
  end

  test "should destroy an issue" do
    # public cannot do this
    assert_no_difference('Issue.count') do
      delete admin_issue_url(@issue)
    end
    assert_response :redirect

    # contributors cannot do this
    sign_in @non_admin
    assert_no_difference('Issue.count') do
      delete admin_issue_url(@issue)
    end

    assert_response :redirect

    # only admins can do this
    sign_in @admin
    assert_difference("Issue.count", -1) do
      delete admin_issue_url(@issue)
    end

    assert_redirected_to admin_issues_url
  end
end
