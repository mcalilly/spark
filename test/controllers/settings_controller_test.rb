require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @setting = settings(:spark_defaults)
  end

  test "should get index" do
    sign_in @admin
    get settings_url
    assert_response :success
  end

  test "should get new" do
    # It should redirect unless the settings are nil
    sign_in @admin
    get new_setting_url
    assert_redirected_to settings_url
  end

  test "should create settings" do
    sign_in @admin
    assert_no_difference('Setting.count') do
      post settings_url, params: { setting: { site_title: @setting.site_title, site_tagline: @setting.site_tagline, site_description: @setting.site_description, email: @setting.email, phone: @setting.phone, address_line_one: @setting.address_line_one, address_line_two: @setting.address_line_two, city: @setting.city, state_or_province: @setting.state_or_province, postal_code: @setting.postal_code, country: @setting.country } }
    end

    assert_redirected_to setting_url(Setting.last)
  end

  test "should show settings" do
    sign_in @admin
    get setting_url(@setting)
    assert_response :success
  end

  test "should get edit" do
    sign_in @admin
    get edit_setting_url(@setting)
    assert_response :success
  end

  test "should update settings" do
    sign_in @admin
    patch setting_url(@setting), params: { setting: { email: "another_email@example.com" } }
    assert_redirected_to setting_url(@setting)
  end

  test "should not allow settings to be deleted, only updated" do
    sign_in @admin
    assert_no_difference("Setting.count") do
      delete setting_url(@setting)
    end
  end
end
