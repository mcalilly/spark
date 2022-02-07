require "application_system_test_case"

class IssuesTest < ApplicationSystemTestCase
  setup do
    @issue = issues(:climate)
    @admin = users(:admin)
    @non_admin = users(:member)
  end

  test "visiting the index should be accessible to everyone" do
    visit issues_path
    assert_current_path issues_path
    assert_text "Issues"
    sign_in @non_admin
    visit issues_path
    assert_current_path issues_path
    assert_text "Issues"
    sign_in @admin
    visit issues_path
    assert_current_path issues_path
    assert_text "Issues"
  end

  test "viewing show page should be accessible to everyone" do
    visit issue_path(@issue)
    assert_current_path issue_path(@issue)
    assert_selector "h1", text: @issue.title
    sign_in @non_admin
    visit issue_path(@issue)
    assert_current_path issue_path(@issue)
    assert_selector "h1", text: @issue.title
    sign_in @admin
    visit issue_path(@issue)
    assert_current_path issue_path(@issue)
    assert_selector "h1", text: @issue.title
  end

end
