require "application_system_test_case"

class UserLogOutTest < ApplicationSystemTestCase
  def setup
    @user = users(:admin)
  end

  test "Users can log out after they sign in to the site" do
    sign_in @user
    visit root_path
    click_on "Log out"
    assert_current_path root_path
    assert_text "Signed out successfully."
    assert_selector "a", text: "Sign in"
  end
end
