class Admin::IssuesController < ApplicationController
  before_action :set_issue, only: %i[ show edit update destroy ]
  after_action :verify_authorized

  def index
    @issues = Issue.all
    authorize @issues
  end

  def show
  end

  def new
    @issue = Issue.new
    authorize @issue
  end

  def edit
  end

  def create
    @issue = Issue.new(issue_params)
    authorize @issue

    respond_to do |format|
      if @issue.save
        format.html { redirect_to admin_issue_url(@issue), notice: I18n.t("issues.create.success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to admin_issue_url(@issue), notice: I18n.t("issues.update.success") }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to admin_issues_url, status: :see_other, notice: I18n.t("issues.delete.success") }
    end
  end

  private
    def set_issue
      @issue = Issue.find(params[:id])
      authorize @issue
    end

    def issue_params
      params.require(:issue).permit(:title, :body)
    end
end
