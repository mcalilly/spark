require 'application_system_test_case'

class UserSignInTest < ApplicationSystemTestCase
  def setup
    @user = users(:kermit)
  end

  test "Sign in page should have the right content" do
    visit sign_in_path
    assert_current_path sign_in_path
    assert_includes title, "Sign in"
    assert_selector "h1", text: "Sign in"
  end

  test "Invalid sign in information" do
    visit sign_in_path
    assert_current_path sign_in_path
    fill_in("Email", with: "")
    fill_in("Password", with: "")
    click_button "Sign in"
    assert_selector "section", text: 'Bad email or password.'
  end

  test "Sign in page should work" do
    visit sign_in_path
    fill_in("Email", with: @user.email)
    fill_in("Password", with: "bacon")
    click_button "Sign in"
    assert_current_path root_path
    within("footer") do
      assert_selector "p", text: "Signed in as #{@user.email}."
      assert_selector "span", text: "User role: Guest"
      assert_no_selector "span", text: "User role: Admin"
    end
  end

end
