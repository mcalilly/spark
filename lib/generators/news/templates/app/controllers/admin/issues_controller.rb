class Admin::NewsClipsController < ApplicationController
  before_action :set_news_clip, only: %i[ show edit update destroy ]
  after_action :verify_authorized

  def index
    @news_clips = NewsClip.all
    authorize @news_clips
  end

  def show
  end

  def new
    @news_clip = NewsClip.new
    authorize @news_clip
  end

  def edit
  end

  def create
    @news_clip = NewsClip.new(news_clip_params)
    authorize @news_clip

    respond_to do |format|
      if @news_clip.save
        format.html { redirect_to admin_news_clip_url(@news_clip), notice: I18n.t("news_clips.create.success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @news_clip.update(news_clip_params)
        format.html { redirect_to admin_news_clips_url(@news_clip), notice: I18n.t("news_clips.update.success") }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @news_clip.destroy

    respond_to do |format|
      format.html { redirect_to admin_news_clips_url, status: :see_other, notice: I18n.t("news_clips.delete.success") }
    end
  end

  private
    def set_news_clip
      @news_clip = NewsClip.find(params[:id])
      authorize @news_clip
    end

    def news_clip_params
      params.require(:news_clip).permit(:publication, :headline, :publication_date, :url, :youtube_id )
    end
end
