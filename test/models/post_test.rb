require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:welcome)
  end

  test 'should be valid' do
    assert @post.valid?
  end

  test "post title should be present" do
    @post.title = '   '
    assert_not @post.valid?
  end
end
