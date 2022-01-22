require 'test_helper'

class SettingPolicyTest < PolicyTest

  setup do
    @admin = users(:admin)
    @guest = users(:guest)
    @current_settings = settings(:spark_defaults)
  end

  test "admin user" do
    assert permit(@admin, Setting.new, :new)
    assert_permissions(@admin, @current_settings, @available_actions,
                       index: true,
                       show: true,
                       create: true,
                       new: true,
                       update: true,
                       edit: true,
                       destroy: true)
  end

  test "guest user" do
    assert permit(@guest, Setting.new, :new)
    assert_permissions(@guest, @current_settings, @available_actions,
                       index: false,
                       show: false,
                       create: false,
                       new: false,
                       update: false,
                       edit: false,
                       destroy: false)
  end

end
