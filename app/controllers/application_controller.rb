require "application_responder"

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # after_action :verify_authorized, except: :index
  # after_action :verify_policy_scoped, only: :index

  self.responder = ApplicationResponder
  respond_to :html

  before_action :authenticate_user!
  before_action :fill_required_info, if: :user_signed_in?

  private
    def after_sign_in_path_for(user)
      if user.profile.incomplete?
        flash[:notice] = "Your profile is incomplete, give people the chance to know you better"
        return edit_user_profile_path(user)
      end

      super(user)
    end

    def fill_required_info
      return if current_user.profile

      redirect_back(fallback_location: new_user_profile_path(current_user))
      flash[:error] = "You need to fill in your first and last name"
    end
end
