require 'application_system_test_case'

class MainNavTest < ApplicationSystemTestCase

  def setup
    visit root_path
    # This is the default but fixes some test flakiness
    page.driver.browser.manage.window.resize_to(1400,1400)
  end

  test "Public nav should have a working links to static pages" do
    visit root_path
    within "nav" do
      click_link "About"
      assert_current_path "/about"
      click_link "Contact"
      assert_current_path "/contact-us"
      click_link Setting.last.site_name
      assert_current_path "/"
    end
  end
end
