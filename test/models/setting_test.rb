require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  def setup
    @setting = settings(:spark_defaults)
  end

  test 'should be valid' do
    assert @setting.valid?
  end

end
