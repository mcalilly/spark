require 'application_system_test_case'

class StaticPagesTest < ApplicationSystemTestCase

  test "Home page should work and have the right content" do
    visit root_path
    assert_title "It's a New Spark Website! • Designed With Spark"
  end
end
