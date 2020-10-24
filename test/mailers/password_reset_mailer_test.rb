require "test_helper"

class PasswordResetMailerTest < ActionMailer::TestCase
  setup do
    # fixtures cause problems in mailer tests
    @user = users(:elvis)
    @user.update(confirmation_token: "c9ce67d1eb6f2d2427f6a6abd5775d9948c020ce")
  end

  test "password reset email" do
    email = ClearanceMailer.change_password(@user)

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ["hi@designwithspark.com"], email.from
    assert_equal [@user.email], email.to
    assert_equal "Change your password", email.subject

  end
end
