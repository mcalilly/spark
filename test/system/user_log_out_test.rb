require "application_system_test_case"

class UserLogOutTest < ApplicationSystemTestCase
  def setup
    @user = users(:member)
  end

  test "Users can log out after they sign in to the site" do
    sign_in @user
    visit root_path
    within "footer" do
      click_on "Log out"
    end
    assert_current_path root_path
  end
end
