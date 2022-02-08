class NewsClipsController < ApplicationController
  before_action :set_all_news_clips, only: [:index, :show]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
  end

  def show
    @news_clip = NewsClip.find(params[:id])
  end

  private
    def set_all_news_clips
      @news_clips = NewsClip.all
    end
end
