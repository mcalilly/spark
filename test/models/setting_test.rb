require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  def setup
    @setting = settings(:spark_defaults)
  end

  test "should be valid" do
    assert @setting.valid?
  end

  test "it should only allow one setting instance in the database" do
    assert_no_difference 'Setting.count' do
      Setting.create(site_title: "Another Site", site_tagline: "Another tagline", site_description: "Another description", email: "test@example.com", facebook_handle: "test", twitter_handle: "test", instagram_handle: "test")
    end
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

  test "Email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @setting.email = valid_address
      assert @setting.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "Email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @setting.email = invalid_address
        assert_not @setting.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
end
