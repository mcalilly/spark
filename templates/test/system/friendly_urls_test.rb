require 'application_system_test_case'

class FriendlyUrlsTest < ApplicationSystemTestCase

  test "/ should be url for the home page" do
    assert root_path == "/"
  end

end
