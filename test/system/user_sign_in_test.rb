require 'application_system_test_case'

class UserSignInTest < ApplicationSystemTestCase
  def setup
    @user = users(:contributor)
  end

  test "Route for Sign in page should have the right content" do
    visit sign_in_path
    assert_current_path "/sign-in"
    assert_selector "h1", text: "Sign in"
  end

  test "Invalid sign in information" do
    visit sign_in_path
    assert_current_path sign_in_path
    within "main" do
      fill_in("Email address", with: "")
      fill_in("Password", with: "")
      click_button "Sign in"
    end
    assert_current_path sign_in_path
    assert_selector "h1", text: "Sign in"
  end

end
