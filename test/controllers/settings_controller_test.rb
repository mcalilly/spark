require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @current_settings = settings(:spark_defaults)
  end

  test "should get index" do
    sign_in @admin
    get settings_url
    assert_redirected_to edit_setting_url(@current_settings)
  end

  test "should get new" do
    # It should redirect unless the settings are nil
    sign_in @admin
    get new_setting_url
    assert_redirected_to setting_url(@current_settings)
  end

  test "should not allow you to create new settings only edit the existing ones" do
    sign_in @admin
    assert_no_difference('Setting.count') do
      post settings_url, params: { setting: { site_title: @current_settings.site_title, site_tagline: @current_settings.site_tagline, site_description: @current_settings.site_description, email: @current_settings.email, phone: @current_settings.phone, address_line_one: @current_settings.address_line_one, address_line_two: @current_settings.address_line_two, city: @current_settings.city, state_or_province: @current_settings.state_or_province, postal_code: @current_settings.postal_code, country: @current_settings.country } }
    end
  end

  test "should show settings" do
    sign_in @admin
    get setting_url(@current_settings)
    assert_response :success
  end

  test "should get edit" do
    sign_in @admin
    get edit_setting_url(@current_settings)
    assert_response :success
  end

  test "should update settings" do
    sign_in @admin
    patch setting_url(@current_settings), params: { setting: { email: "another_email@example.com" } }
    assert_redirected_to setting_url(@current_settings)
  end

  test "destroy action should work if needed, though we're not showing this to the user" do
    sign_in @admin
    assert_difference("Setting.count", -1) do
      delete setting_url(@current_settings)
    end
  end
end
