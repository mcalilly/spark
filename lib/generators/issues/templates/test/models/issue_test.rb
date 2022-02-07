require "test_helper"

class IssueTest < ActiveSupport::TestCase
  def setup
    @issue = issues(:climate)
  end

  test "title should be present" do
    @issue.title = '   '
    assert_not @issue.valid?
  end

  test "title should be unique" do
    duplicate_name = @issue.dup
    duplicate_name.title = @issue.title.upcase
    @issue.save
    assert_not duplicate_name.valid?
  end

  test "body should be present" do
    @issue.body = nil
    assert_not @issue.valid?
  end
end
