require "application_system_test_case"

class UserLogOutTest < ApplicationSystemTestCase
  def setup
    @user = users(:admin)
  end

  test "Users can log out after they sign in to the site" do
    sign_in @user
    visit "/admin"
    within ".sidebar-desktop" do
      find_link("Log out", match: :first).click
    end
    assert_current_path root_path
  end
end
