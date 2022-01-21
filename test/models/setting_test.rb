require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  def setup
    @setting = settings(:spark_defaults)
  end

  test "should be valid" do
    assert @setting.valid?
  end

  test "site email should be present" do
    @setting.email = '   '
    assert_not @setting.valid?
  end

  test "site title should be present" do
    @setting.site_title = '   '
    assert_not @setting.valid?
  end

  test "site description should be present" do
    @setting.site_description = '   '
    assert_not @setting.valid?
  end

end
