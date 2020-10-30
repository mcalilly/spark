require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:elvis)
    @setting = settings(:spark_defaults)
  end

  test "should get index" do
    get settings_path(as: @admin)
    assert_response :success
  end

  test "should get new" do
    get new_setting_path(as: @admin)
    assert_response :success
  end

  test "should create settings" do
    assert_difference('Setting.count') do
      post settings_path(as: @admin), params: { setting: { email: @setting.email, site_name: @setting.site_name, site_description: @setting.site_description } }
    end

    assert_redirected_to setting_path(Setting.last)
  end

  test "should show settings" do
    get setting_path(@setting, as: @admin)
    assert_response :success
  end

  test "should get edit" do
    get edit_setting_path(@setting, as: @admin)
    assert_response :success
  end

  test "should update settings" do
    patch setting_path(@setting, as: @admin), params: { setting: { email: "another_email@example.com" } }
    assert_redirected_to setting_path(@setting)
  end

  test "should destroy setting" do
    assert_difference("Setting.count", -1) do
      delete setting_path(@setting, as: @admin)
    end

    assert_redirected_to settings_path
  end
end
