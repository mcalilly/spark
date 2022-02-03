require 'application_system_test_case'

class MobileNavTest < ApplicationSystemTestCase

  def setup
    visit root_path
    # Mobile nav appears for another below the lg breakpoint
    page.driver.browser.manage.window.resize_to(700,1200)
    click_button "Open menu"
  end

  test "should have mobile links to the Static pages" do
    within(".mobile-nav") do
      click_link "About"
    end
    assert_current_path "/about"
    click_button "Open menu"
    within(".mobile-nav") do
      click_link "Contact"
    end
    assert_current_path "/contact-us"
  end
end
