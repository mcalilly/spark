require 'application_system_test_case'

class UserSignInTest < ApplicationSystemTestCase
  def setup
    @user = users(:member)
  end

  test "Route for Sign in page should have the right content" do
    visit sign_in_path
    assert_current_path "/sign-in"
    assert_selector "h1", text: "Sign in"
  end

  test "/admin should forward you to the sign in page" do
    visit "/admin"
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

  test "Valid sign in information" do
    visit sign_in_path
    assert_current_path sign_in_path
    within "main" do
      fill_in("Email address", with: "admin@example.com")
      fill_in("Password", with: "password")
      click_button "Sign in"
    end
    within ".sidebar-desktop" do
      click_on "Log out"
    end
    assert_current_path root_path
    visit "/admin"
    within "main" do
      fill_in("Email address", with: "admin@example.com")
      fill_in("Password", with: "password")
      click_button "Sign in"
    end
    within ".sidebar-desktop" do
      click_on "Log out"
    end
    assert_current_path root_path
  end
end
