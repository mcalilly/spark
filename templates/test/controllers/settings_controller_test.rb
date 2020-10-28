require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:elvis)
    @setting = settings(:spark_defaults)
  end

  test "should get index" do
    get settings_url(as: @admin)
    assert_response :success
  end

  test "should get new" do
    get new_setting_url(as: @admin)
    assert_response :success
  end

  test "should create settings" do
    assert_difference('Setting.count') do
      post settings_url(as: @admin), params: { setting: { email: @setting.email, site_name: @setting.site_name, site_description: @setting.site_description } }
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
