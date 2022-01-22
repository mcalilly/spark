class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @settings = Setting.all
    authorize @settings
    if Setting.count > 0
      redirect_to edit_setting_path(Setting.last)
    end
  end

  def show
  end

  def new
    @setting = Setting.new
    authorize @setting
    if Setting.count > 0
      redirect_to setting_path(Setting.last)
    end
  end

  def edit
  end

  def create
    @setting = Setting.new(setting_params)
    authorize @setting

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: I18n.t("settings.create.success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: I18n.t("settings.update.success" }
      else
         format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url, notice: I18n.t("settings.delete.success" }
    end
  end

  private
    def set_setting
      @setting = Setting.last
      authorize @setting
    end

    def setting_params
      params.require(:setting).permit(:site_title, :site_tagline, :site_description, :email, :phone, :twitter_handle, :facebook_handle, :instagram_handle, :address_line_one, :address_line_two, :city, :state_or_province, :postal_code, :country)
    end
end
