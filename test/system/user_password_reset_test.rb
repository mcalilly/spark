require 'application_system_test_case'

class UserPasswordResetTest < ApplicationSystemTestCase
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:elvis)
  end

  test "should allow you to request a password reset email" do
    visit sign_in_path
    click_link "forgot password?"
    assert_current_path new_password_path
    fill_in "Email address", with: @user.email
    click_button "Reset password"
    assert_selector "h1", text: "Your password reset email is on the way!"
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
end
