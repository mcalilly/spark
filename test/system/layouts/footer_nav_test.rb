require 'application_system_test_case'

class FooterTest < ApplicationSystemTestCase

  # Copyright area
  test "should include a copyright" do
    visit root_path
    within("footer") do
     assert_selector "p", text: "© #{Time.zone.now.year}. #{Setting.last.site_title}."
    end
  end

  test "should include social links" do
    visit root_path
    within("footer") do
      assert_selector(:link, text: "Facebook", href: "https://facebook.com/#{Setting.last.facebook_handle}")
      assert_selector(:link, text: "Twitter", href: "https://twitter.com/#{Setting.last.twitter_handle}")
      assert_selector(:link, text: "Instagram", href: "https://instagram.com/#{Setting.last.instagram_handle}")
    end
  end

end
