require 'application_system_test_case'

class UserPasswordResetTest < ApplicationSystemTestCase
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:member)
  end

  test "should allow you to request a password reset email" do
    visit sign_in_path
    click_link "Forgot your password?"
    assert_current_path "/users/password/new"
    using_wait_time(7) do
      fill_in "user[email]", with: @user.email
    end
    click_button "Send me reset password instructions"
    using_wait_time(5) do
      assert_text "You will receive an email with instructions on how to reset your password in a few minutes."
    end
  end
end
