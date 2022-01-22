require "application_system_test_case"

class StaticPagesTest < ApplicationSystemTestCase
  def setup
    @base_title = " • " + Setting.last.site_title
  end

  test "home page has the correct public content and sign in link is shown when not logged in" do
    visit root_path
    assert_selector "h1", text: "#{Setting.last.site_title}"
    assert_selector "p", text: "#{Setting.last.site_description}"
    assert_no_selector "a", text: "Log Out"
  end

  test "about page has the correct public content" do
    visit about_path
    assert_selector "h1", text: "About Us"
  end

  test "contact page has the correct public content" do
    visit contact_path
    assert_selector "h1", text: "Contact Us"
    assert_selector "a", text: "#{Setting.last.email}"
  end
end
