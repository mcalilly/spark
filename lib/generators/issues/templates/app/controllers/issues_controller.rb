class IssuesController < ApplicationController
  before_action :set_all_issues, only: [:index, :show]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
  end

  def show
    @issue = Issue.find(params[:id])
  end

  private
    def set_all_issues
      @issues = Issue.all
    end
end
