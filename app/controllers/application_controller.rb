require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_action :authenticate_user!

  private

    def authorize_user(content)
      unless current_user.owns?(content)
        flash[:error] = "You are not authorized to do that"
        redirect_back(fallback_location: root_path)
      end
    end

    def after_sign_in_path_for(user)
      if user.profile.incomplete?
        flash[:notice] = "Your profile is incomplete, give people the chance to know you better"
        return edit_user_profile_path(user)
      end

      super(user)
    end
end
