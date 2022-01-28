require 'test_helper'

class SettingPolicyTest < PolicyTest

  setup do
    @admin = users(:admin)
    @member = users(:member)
    @current_settings = settings(:spark_defaults)
    @available_actions = [:index, :show, :create, :new, :update, :edit, :destroy]
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

  test "member user" do
    refute permit(@member, Setting.new, :new)
    assert_permissions(@member, @current_settings, @available_actions,
                       index: false,
                       show: false,
                       create: false,
                       new: false,
                       update: false,
                       edit: false,
                       destroy: false)
  end

end
