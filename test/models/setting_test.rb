require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  def setup
    @setting = settings(:spark_defaults)
  end

  test "should be valid" do
    assert @setting.valid?
  end

  test "it should only allow one setting instance in the database" do
    duplicate_settings = Setting.new(site_name: "Another Site", site_tagline: "Another tagline", site_description: "Another description", email: "test@example.com", facebook_handle: "test", twitter_handle: "test", instagram_handle: "test")
    refute duplicate_settings.valid?
  end

  test "site title should be present" do
    @setting.site_title = '   '
    assert_not @setting.valid?
  end

  test "tagline should be present" do
    @setting.site_tagline = '   '
    assert_not @setting.valid?
  end

  test "site description should be present" do
    @setting.site_description = '   '
    assert_not @setting.valid?
  end

  test "facebook handle should be present" do
    @setting.facebook_handle = '   '
    assert_not @setting.valid?
  end

  test "twitter handle should be present" do
    @setting.twitter_handle = '   '
    assert_not @setting.valid?
  end

  test "instagram handle should be present" do
    @setting.instagram_handle = '   '
    assert_not @setting.valid?
  end

  test "site email should be present" do
    @setting.email = '   '
    assert_not @setting.valid?
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
    duplicate_user = @admin.dup
    duplicate_user.email = @admin.email.upcase
    @admin.save
    assert_not duplicate_user.valid?
  end

  test "Email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @potential_user.email = mixed_case_email
    @potential_user.save
    assert_equal mixed_case_email.downcase, @potential_user.reload.email
  end

end
