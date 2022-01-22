class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  layout :determine_layout

  private
    def determine_layout
      if current_user && controller_name != "static_pages"
        "admin"
      elsif controller_name == "sessions" || controller_name == "users" || controller_name == "registrations" || controller_name == "passwords"
        "devise"
      else
        "public"
      end
    end

    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore

      flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
      redirect_to(request.referrer || root_path)
    end
end
