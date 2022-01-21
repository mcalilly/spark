require "application_system_test_case"

class UserTest < ActiveSupport::TestCase
  def setup
    @signed_up_user = users(:admin)
    @non_admin = users(:guest)
    @potential_user = User.new(
                           email: "new_user@example.com",
                           password: "foobar",
                           role: "admin"
                          )
end

  test "Should be valid" do
    assert @signed_up_user.valid?
  end

  test "Email should be present" do
    @potential_user.email = "     "
    assert_not @potential_user.valid?
  end

  test "Email should not be too long" do
    @potential_user.email = "a" * 244 + "@example.com"
    assert_not @potential_user.valid?
  end

  test "Email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @potential_user.email = valid_address
      assert @potential_user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "Email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @potential_user.email = invalid_address
        assert_not @potential_user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "Email addresses should be unique" do
    duplicate_user = @signed_up_user.dup
    duplicate_user.email = @signed_up_user.email.upcase
    @signed_up_user.save
    assert_not duplicate_user.valid?
  end

  test "Email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @potential_user.email = mixed_case_email
    @potential_user.save
    assert_equal mixed_case_email.downcase, @potential_user.reload.email
  end

  test "Password should be present (nonblank)" do
    @potential_user.password = " " * 6
    assert_not @potential_user.valid?
  end

  test "New users should not be admins" do
    assert @signed_up_user.admin?
    assert_not @non_admin.admin?
    assert @non_admin.guest?
  end

end
