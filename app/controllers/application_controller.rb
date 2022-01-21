class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pundit
  before_action :require_login
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  layout :determine_layout

  private
    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore

     flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
     redirect_to(request.referrer || root_path)
    end

    def determine_layout
      if signed_in? && current_user.role == "admin"
        "admin"
      else
        "public"
      end
    end
end
