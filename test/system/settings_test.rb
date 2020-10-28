require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  setup do
    @setting = settings(:spark_defaults)
    @admin = users(:elvis)
    @non_admin = users(:kermit)
  end

  test "visiting the index should be accessible to admins" do
    visit settings_url(as: @admin)
    assert_selector "h1", text: "Settings"
  end

  test "viewing settings show should be accessible to admins" do
    visit settings_url(as: @admin)
    click_on "Show", match: :first
    assert_current_path setting_path(@setting)
    assert_selector "h1", text: "Settings"
  end

  test "non-admins should not be able to create, edit, or delete" do
    visit new_setting_url(as: @non_admin)
    within(".flash") do
      assert_text "You cannot perform this action."
    end

    visit settings_url(as: @non_admin)
    click_on "Edit", match: :first
    within(".flash") do
      assert_text "You cannot perform this action."
    end

    visit settings_url(as: @non_admin)
    click_on "Show", match: :first
    assert_selector "a", text: "Delete", count: 0
  end

  test "creating a Setting" do
    visit new_setting_url(as: @admin)
    fill_in "Email", with: @setting.email
    fill_in "Site name", with: @setting.site_name
    fill_in "Site description", with: @setting.site_description
    fill_in "Tracking codes", with: @setting.tracking_codes
    fill_in "Twitter handle", with: @setting.twitter_handle
    fill_in "Facebook handle", with: @setting.facebook_handle
    fill_in "Instagram handle", with: @setting.instagram_handle
    fill_in "Street", with: @setting.street
    fill_in "City", with: @setting.city
    fill_in "State", with: @setting.state
    fill_in "Zip", with: @setting.zip
    click_button "Create Setting"
    within(".flash") do
      assert_text "Setting was successfully created"
    end
  end

  test "updating an Setting" do
    visit settings_url(as: @admin)
    click_on "Edit", match: :first
    fill_in "Email", with: "yet_another_site_name@example.com"
    click_button "Update Setting"

    within(".flash") do
      assert_text "Setting was successfully updated"
    end
  end

  test "destroying Settings" do
    visit settings_url(as: @admin)
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    within(".flash") do
      assert_text "Setting was successfully destroyed"
    end
  end
end
