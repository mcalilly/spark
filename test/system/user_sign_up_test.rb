require "application_system_test_case"

class UserSignUpTest < ApplicationSystemTestCase
  test "Sign up page should work" do
    visit sign_up_path
    assert_selector "h1", text: "Sign up"
  end

  test "Invalid sign up information" do
    visit sign_up_path
    within "main" do
      fill_in("Email address", with: "")
      fill_in("Password", with: "")
      click_button "Sign up"
      assert_text "errors"
    end
  end

  test "Valid sign up information" do
    visit sign_up_path
    within "main" do
      fill_in("Email address", with: "user@example.com")
      fill_in("Password", with: "password")
      click_button "Sign up"
    end
    assert_current_path root_path
    within "footer" do
      assert_selector "a", text: "Log out"
    end
  end

end
