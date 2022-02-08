require "test_helper"

class NewsClipTest < ActiveSupport::TestCase
  def setup
    @news_clip = news_clips(:nytimes_article)
  end

  test "publication should be present" do
    @news_clip.publication = '   '
    assert_not @news_clip.valid?
  end

  test "publication date should be present" do
    @news_clip.publication_date = '   '
    assert_not @news_clip.valid?
  end

end
