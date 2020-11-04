require 'application_system_test_case'

class StaticPagesTest < ApplicationSystemTestCase

  test "Home page should work and have the right content" do
    visit root_path
    assert_title "Spark CMS • Designed With Spark"
  end
end
