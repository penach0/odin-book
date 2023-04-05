require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_action :authenticate_user!

  def after_sign_in_path_for(user)
    return edit_user_profile_path(user) if user.profile.incomplete?

    super(user)
  end
end
