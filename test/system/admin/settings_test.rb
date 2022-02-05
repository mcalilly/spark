require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  setup do
    @current_settings = settings(:spark_defaults)
    @admin = users(:admin)
    @non_admin = users(:member)
  end

  test "visiting the index should be accessible to admins and redirect to edit the current settings" do
    sign_in @admin
    visit admin_settings_path
    assert_current_path edit_admin_setting_path(@current_settings)
    assert_selector "h1", text: "Edit Settings"
  end

  test "viewing settings show should be accessible to admins" do
    sign_in @admin
    visit admin_settings_path
    assert_selector "h1", text: "Settings"
  end

  test "non-admins should not be able to view, create, edit, or delete" do
    # first test the general public
    visit new_admin_setting_path
    assert_text "Sign in to your account"
    visit edit_admin_setting_path(@current_settings)
    assert_text "Sign in to your account"
    visit admin_setting_path(@current_settings)
    assert_text "Sign in to your account"
    visit admin_settings_path
    assert_text "Sign in to your account"

    # Then test as a non admin
    sign_in @non_admin
    visit new_admin_setting_path
    assert_text "You don't have permission to update settings."

    visit edit_admin_setting_path(@current_settings)
    assert_text "You don't have permission to update settings."

    visit admin_setting_path(@current_settings)
    assert_no_selector "h1", text: "Settings"
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"

    visit admin_settings_path
    assert_no_selector "h1", text: "Settings"
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"
  end

  test "updating an Setting should happen inline on the settings show page" do
    sign_in @admin
    visit admin_setting_path(@current_settings)
    find_link("Edit", match: :first).click
    fill_in "setting[site_title]", with: "An Updated Site Title"
    click_button "Save"
    assert_text "An Updated Site Title"
  end

  test "no one should see a link to destroy Settings" do
    sign_in @admin
    visit admin_settings_path
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"
  end
end
