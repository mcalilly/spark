require "application_system_test_case"

class OnboardingTest < ApplicationSystemTestCase
  setup do
    @admin = users(:elvis)
    @setting = settings(:spark_defaults)
  end

  test "new sites should be prompted to add settings if they are empty" do
    # when setting up a new site, admins should only see a 'New Settings' button when there are no settings in the database (this would happen if they forget to run initial db/seeds on production)
    s = Setting.last
    s.delete
    visit settings_url(as: @admin)
    assert_selector "h1", text: "Settings"
    click_on "Add Settings"
    assert_current_path new_setting_path
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
    within(".sidebar-desktop") do
      click_on "Settings"
    end
    assert_selector "a", text: "Update Settings"
  end

end
