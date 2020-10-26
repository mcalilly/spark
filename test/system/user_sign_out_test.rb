require "application_system_test_case"

class UserSignOutTest < ApplicationSystemTestCase
  def setup
    @user = users(:kermit)
  end

  test "Users can sign out after they sign in to the site" do
    visit sign_in_path
    fill_in("Email", with: @user.email)
    fill_in("Password", with: "staygreen")
    click_button "Sign in"
    assert_current_path root_path
    assert_no_link "Sign in"
    within("footer") do
      assert_selector "p", text: "Signed in as #{@user.email}."
      click_link "Sign out"
    end
    assert_current_path sign_in_path
 end
end
