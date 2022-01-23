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
    visit new_setting_path
    assert_text "You must login"
    sign_in @non_admin
    visit new_setting_path
    within(".flash") do
      assert_text "You cannot perform this action."
    end

    visit edit_setting_path
    assert_text "You must login"
    sign_in @non_admin
    visit edit_setting_path(@current_settings)
    within(".flash") do
      assert_text "You cannot perform this action."
    end

    visit setting_path(@current_settings)
    assert_text "You must login"
    sign_in @non_admin
    visit setting_path(@current_settings)
    assert_no_selector "h1", text: "Settings"
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"

    visit settings_path
    assert_text "You must login"
    sign_in @non_admin
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
    fill_in "Twitter handle", with: "new"
    fill_in "Facebook handle", with: "new"
    fill_in "Instagram handle", with: "new"
    fill_in "Address line one", with: "1234 Main Street"
    fill_in "Address line one", with: "Apt 7"
    fill_in "City", with: "Brooklyn"
    fill_in "State", with: "NY"
    fill_in "Zip code", with: "11211"
    fill_in "Country", with: "United States"
    click_button "Save"
    within(".flash") do
      assert_text "Setting was successfully created"
    end
  end

  test "updating an Setting" do
    sign_in @admin
    visit settings_path
    click_on "Update Settings", match: :first
    fill_in "Email", with: "yet_another_email@example.com"
    click_button "Save"

    within(".flash") do
      assert_text "Setting was successfully updated"
    end
  end

  test "no one should see a link to destroy Settings" do
    sign_in @admin
    visit settings_path
    assert_no_selector "a", text: "Delete"
    assert_no_selector "a", text: "Destroy"
  end
end
