class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show]
  after_action :verify_authorized

  def index
    @settings = Setting.all
    authorize @settings
  end

  def show
  end

  def new
    @setting = Setting.new
    authorize @setting
    if Setting.count > 0
      redirect_to settings_path
    end
  end

  def edit
  end

  def create
    @setting = Setting.new(setting_params)
    authorize @setting

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url, notice: 'Setting was successfully destroyed.' }
      format.json { head :no_content }
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
