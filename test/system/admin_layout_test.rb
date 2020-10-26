require "application_system_test_case"

class AdminLayoutTest < ApplicationSystemTestCase

  setup do
    @post = posts(:welcome)
    @admin = users(:elvis)
    @non_admin = users(:kermit)
  end

  test "non-admins should not see the admin layout" do
    visit posts_url(as: @non_admin)
    assert_selector ".sidebar-desktop", count: 0
  end

  test "admins should see the admin layout" do
    visit root_path(as: @non_admin)
    assert_selector ".sidebar-desktop", count: 1
    within(".sidebar-desktop") do
      assert_selector "a", text: "Blog"
      assert_selector "a", text: "Settings"
      assert_selector "p", text: "#{@admin.email}"
      click_on "Sign out"
    end
    assert_current_path root_path
  end
end
