require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  setup do
    @current_settings = settings(:spark_defaults)
    @admin = users(:admin)
    @non_admin = users(:guest)
  end

  test "visiting the index should be accessible to admins and redirect to edit the current settings" do
    sign_in @admin
    visit settings_path
    assert_current_path edit_setting_path(@current_settings)
    assert_selector "h1", text: "Edit Settings"
  end

  test "viewing settings show should be accessible to admins" do
    sign_in @admin
    visit settings_path
    assert_selector "h1", text: "Settings"
  end

  test "non-admins should not be able to view, create, edit, or delete" do
    # first test the general public
    visit new_setting_path
    assert_text "Sign in to your account"
    visit edit_setting_path(@current_settings)
    assert_text "Sign in to your account"
    visit setting_path(@current_settings)
    assert_text "Sign in to your account"
    visit settings_path
    assert_text "Sign in to your account"

    # Then test as a non admin    
    sign_in @non_admin
    visit new_setting_path
    assert_text "You don't have permission to update settings."

    visit edit_setting_path(@current_settings)
    assert_text "You don't have permission to update settings."

    visit setting_path(@current_settings)
    assert_no_selector "h1", text: "Settings"
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"

    visit settings_path
    assert_no_selector "h1", text: "Settings"
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"
  end

  test "creating a Setting" do
    s = Setting.last
    s.delete
    sign_in @admin
    visit settings_path
    assert_selector "h1", text: "Settings"
    click_on "Add Settings"
    assert_current_path new_setting_path
    fill_in "Site title", with: "A new title"
    fill_in "Site description", with: "A new description"
    fill_in "Site tagline", with: "A new tagline"
    fill_in "Email", with: "new@example.com"
    fill_in "Phone", with: "777-888-9999"
    fill_in "Twitter handle", with: "new_twitter"
    fill_in "Facebook handle", with: "new_facebook"
    fill_in "Instagram handle", with: "new_instagram"
    fill_in "Address line one", with: "1234 Main Street"
    fill_in "Address line one", with: "Apt 7"
    fill_in "City", with: "Brooklyn"
    fill_in "State", with: "NY"
    fill_in "Zip code", with: "11211"
    fill_in "Country", with: "United States"
    click_button "Save"
    assert_text "Your new settings were successfully created."
  end

  test "updating an Setting" do
    sign_in @admin
    visit edit_setting_path(@current_settings)
    fill_in "Site title", with: "An Updated Site Title"
    click_button "Save"
    assert_text "Your settings were updated."
  end

  test "no one should see a link to destroy Settings" do
    sign_in @admin
    visit settings_path
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"
  end
end
