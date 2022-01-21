require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  setup do
    @setting = settings(:spark_defaults)
    # @admin = users(:admin)
    # @non_admin = users(:kermit)
  end
#
#   test "visiting the index should be accessible to admins" do
#     visit settings_path(as: @admin)
#     assert_selector "h1", text: "Settings"
#   end
#
#   test "viewing settings show should be accessible to admins" do
#     visit settings_path(@setting, as: @admin)
#     assert_selector "h1", text: "Settings"
#     assert_selector "a", text: "Update Settings"
#   end
#
#   test "non-admins should not be able to view, create, edit, or delete" do
#     visit new_setting_path(as: @non_admin)
#     within(".flash") do
#       assert_text "You cannot perform this action."
#     end
#
#     visit edit_setting_path(@setting, as: @non_admin)
#     within(".flash") do
#       assert_text "You cannot perform this action."
#     end
#
#     visit setting_path(@setting, as: @non_admin)
#     assert_no_selector "h1", text: "Your Current Settings"
#     assert_no_selector "a", text: "Delete"
#     assert_no_selector "a", text: "Destroy"
#
#     visit settings_path(as: @non_admin)
#     assert_no_selector "h1", text: "Your Current Settings"
#     assert_no_selector "a", text: "Delete"
#     assert_no_selector "a", text: "Destroy"
#   end
#
#   test "creating a Setting" do
#     s = Setting.last
#     s.delete
#     visit settings_path(as: @admin)
#     assert_selector "h1", text: "Settings"
#     click_on "Add Settings"
#     assert_current_path new_setting_path
#     fill_in "Email", with: @setting.email
#     fill_in "Site name", with: @setting.site_name
#     fill_in "Site description", with: @setting.site_description
#     fill_in "Tracking codes", with: @setting.tracking_codes
#     fill_in "Twitter handle", with: @setting.twitter_handle
#     fill_in "Facebook handle", with: @setting.facebook_handle
#     fill_in "Instagram handle", with: @setting.instagram_handle
#     fill_in "Street", with: @setting.street
#     fill_in "City", with: @setting.city
#     fill_in "State", with: @setting.state
#     fill_in "Zip", with: @setting.zip
#     click_button "Save"
#     within(".flash") do
#       assert_text "Setting was successfully created"
#     end
#   end
#
#   test "updating an Setting" do
#     visit settings_path(as: @admin)
#     click_on "Update Settings", match: :first
#     fill_in "Email", with: "yet_another_site_name@example.com"
#     click_button "Save"
#
#     within(".flash") do
#       assert_text "Setting was successfully updated"
#     end
#   end
#
#   test "no one should see a link to destroy Settings" do
#     visit settings_path(as: @admin)
#     assert_no_selector "a", text: "Delete"
#     assert_no_selector "a", text: "Destroy"
#   end
# end
