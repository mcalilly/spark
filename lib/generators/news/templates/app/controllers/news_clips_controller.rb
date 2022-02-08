class NewsClipsController < ApplicationController
  before_action :set_all_news_clips, only: [:index, :show]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @featured_video = NewsClip.where.not(youtube_id: "").last
    @videos = NewsClip.where.not(youtube_id: "").offset(1)
    @articles = NewsClip.where(youtube_id: "")
  end

  def show
    @news_clip = NewsClip.find(params[:id])
  end

  private
    def set_all_news_clips
      @news_clips = NewsClip.all
    end
end
