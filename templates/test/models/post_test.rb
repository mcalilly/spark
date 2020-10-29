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

  test "post title should be unique" do
    duplicate_title = @post.dup
    duplicate_title.title = @post.title.upcase
    @post.save
    assert_not duplicate_title.valid?
  end
end
