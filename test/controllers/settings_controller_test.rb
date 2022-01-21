require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @setting = settings(:spark_defaults)
  end

  test "should get index" do
    get settings_url(as: @admin)
    assert_response :success
  end

  test "should get new" do
    # It should redirect unless the settings are nil
    get new_setting_url(as: @admin)
    assert_redirected_to settings_url
    # Show new only when there are no settings at all
    assert_difference("Setting.count", -1) do
      delete setting_url(@setting, as: @admin)
    end
    get new_setting_url(as: @admin)
    assert_response :success
  end

  test "should create settings" do
    assert_difference('Setting.count') do
      post settings_url(as: @admin), params: { setting: { site_title: @setting.site_title, site_tagline: @setting.site_tagline, site_description: @setting.site_description, email: @setting.email, phone: @setting.phone, address_line_one: @setting.address_line_one, address_line_two: @setting.address_line_two, city: @setting.city, state_or_province: @setting.state_or_province, postal_code: @setting.postal_code, country, @setting.country } }
    end

    assert_redirected_to setting_url(Setting.last)
  end

  test "should show settings" do
    get setting_url(@setting, as: @admin)
    assert_response :success
  end

  test "should get edit" do
    get edit_setting_url(@setting, as: @admin)
    assert_response :success
  end

  test "should update settings" do
    patch setting_url(@setting, as: @admin), params: { setting: { email: "another_email@example.com" } }
    assert_redirected_to setting_url(@setting)
  end

  test "should destroy setting" do
    assert_difference("Setting.count", -1) do
      delete setting_url(@setting, as: @admin)
    end

    assert_redirected_to settings_url
  end
end
