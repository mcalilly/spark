require "test_helper"

class AdminNewsClipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @non_admin = users(:member)
    @news_clip = news_clips(:nytimes_article)
  end

  test "should get new" do
    # public cannot do this
    get new_admin_news_clip_url
    assert_response :redirect

    # contributors cannot do this
    sign_in @non_admin
    get new_admin_news_clip_url
    assert_response :redirect

    # admins can view
    sign_in @admin
    get new_admin_news_clip_url
    assert_response :success
  end

  test "should create a news clip" do
    # public cannot do this
    assert_no_difference('NewsClip.count') do
      post admin_news_clips_url, params: { news_clip: { publication: "NY Daily News", publication_date: 1.week.ago, headline: "Dems, get behind Biden’s bills", url: "https://www.nydailynews.com/opinion/ny-oped-dems-get-behind-bidens-bills-20210924-e7ujqjd7ofac5p73fkbvwzfluq-story.html", youtube_id: "" } }
    end
    assert_response :redirect

    # contributors cannot do this
    sign_in @non_admin
    assert_no_difference('NewsClip.count') do
      post admin_news_clips_url, params: { news_clip: { publication: "NY Daily News", publication_date: 1.week.ago, headline: "Dems, get behind Biden’s bills", url: "https://www.nydailynews.com/opinion/ny-oped-dems-get-behind-bidens-bills-20210924-e7ujqjd7ofac5p73fkbvwzfluq-story.html", youtube_id: "" }  }
    end
    assert_response :redirect

    # admins can create
    sign_in @admin
    assert_difference('NewsClip.count') do
      post admin_news_clips_url, params: { news_clip: { publication: "NY Daily News", publication_date: 1.week.ago, headline: "Dems, get behind Biden’s bills", url: "https://www.nydailynews.com/opinion/ny-oped-dems-get-behind-bidens-bills-20210924-e7ujqjd7ofac5p73fkbvwzfluq-story.html", youtube_id: "" }  }
    end
    assert_response :redirect
  end

  test "should get edit" do
    # public cannot do this
    get edit_admin_news_clip_url(@news_clip)
    assert_response :redirect

    # contributors cannot do this
    sign_in @non_admin
    get edit_admin_news_clip_url(@news_clip)
    assert_response :redirect

    # admins can edit
    sign_in @admin
    get edit_admin_news_clip_url(@news_clip)
    assert_response :success
  end

  test "should update a news clip" do
    # public cannot do this
    patch admin_news_clip_url(@news_clip), params: { news_clip: { publication: "NY Times", publication_date: 1.year.ago, headline: "A Revised Headline" } }
    assert_response :redirect
    refute_match("A Revised Headline", @news_clip.title)

    # contributors cannot do this
    sign_in @non_admin
    patch admin_news_clip_url(@news_clip), params: { news_clip: { publication: "NY Times", publication_date: 1.year.ago, headline: "A Revised Headline" } }
    assert_response :redirect
    refute_match("A Revised Headline", @news_clip.title)

    # only admins can do this
    sign_in @admin
    patch admin_news_clip_url(@news_clip), params: { news_clip: { publication: "NY Times", publication_date: 1.year.ago, headline: "A Revised Headline" } }
    assert_redirected_to admin_news_clip_url(@news_clip)
  end

  test "should destroy a news clip" do
    # public cannot do this
    assert_no_difference('NewsClip.count') do
      delete admin_news_clip_url(@news_clip)
    end
    assert_response :redirect

    # contributors cannot do this
    sign_in @non_admin
    assert_no_difference('NewsClip.count') do
      delete admin_news_clip_url(@news_clip)
    end

    assert_response :redirect

    # only admins can do this
    sign_in @admin
    assert_difference("NewsClip.count", -1) do
      delete admin_news_clip_url(@news_clip)
    end

    assert_redirected_to admin_news_clips_url
  end
end
