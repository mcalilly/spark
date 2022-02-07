require "application_system_test_case"

class AdminIssuesTest < ApplicationSystemTestCase
  setup do
    @issue = issues(:climate)
    @admin = users(:admin)
    @non_admin = users(:member)
  end

  test "non-admins should not be able to view, create, edit, or delete" do
    # first test the general public
    visit new_admin_issue_path
    assert_text "Sign in to your account"
    visit edit_admin_issue_path(@issue)
    assert_text "Sign in to your account"
    visit admin_issue_path(@issue)
    assert_text "Sign in to your account"
    visit admin_issues_path
    assert_text "Sign in to your account"

    # Then test as a non admin
    sign_in @non_admin
    visit new_admin_issue_path
    assert_text "You don't have permission to update issues."

    visit edit_admin_issue_path(@issue)
    assert_text "You don't have permission to update issues."

    visit admin_issue_path(@issue)
    assert_no_selector "h1", text: "Issues"
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"

    visit admin_issues_path
    assert_no_selector "h1", text: "Issues"
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"
  end

  test "admins can create an new issue" do
    sign_in @admin
    visit admin_issues_path
    click_on "Add an Issue"
    fill_in "issue[title]", with: "It's a New Issue"
    find(:css, "trix-editor").set("This is the body of the new issue.")
    click_button "Save"
    assert_text "It's a New Issue"
  end

  test "admins should be able to edit an issue" do
    sign_in @admin
    visit admin_issue_path(@issue)
    find_link("Edit", match: :first).click
    fill_in "issue[title]", with: "We've Edited This Title"
    find(:css, "trix-editor").set("We've edited the body of this issue.")
    click_button "Save"
    assert_text "We've Edited This Title"
  end

  test "only admins can delete issues" do
    visit admin_issue_path(@issue)
    assert_no_text "Delete"
    assert_text "You need to sign in"

    sign_in @non_admin
    visit admin_issue_path(@issue)
    assert_no_text "Delete"

    sign_in @admin
    visit admin_issue_path(@issue)
    page.accept_confirm do
      click_link "Delete", match: :first
    end
    assert_text "This issue has been deleted."
  end
end
