require "application_system_test_case"

class UserSignUpTest < ApplicationSystemTestCase
  test "Sign up page and form should work to create a new user" do
    visit sign_up_path
    assert_current_path sign_up_path
    assert_includes title, "Sign up"
    assert_selector "h1", text: "Sign up"
  end

  test "Invalid sign up information" do
    visit sign_up_path
    assert_current_path sign_up_path
    fill_in("Email", with: "")
    fill_in("Password", with: "")
    click_button "Sign up"
    assert_selector ".errors", text: "The form contains 5 errors."
  end

  test "Valid sign up information" do
    visit sign_up_path
    assert_current_path sign_up_path
    fill_in("Email", with: "user@example.com")
    fill_in("Password", with: "password")
    click_button "Sign up"
    assert_current_path root_path
    within("footer") do
      assert_selector "p", text: "Signed in as user@example.com."
    end
  end

end
