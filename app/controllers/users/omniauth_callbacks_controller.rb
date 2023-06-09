class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: [:facebook, :google_oauth2, :github]

  def facebook
    handle_auth("Facebook")
  end

  def google_oauth2
    handle_auth("Google")
  end

  def github
    handle_auth("Github")
  end

  def handle_auth(kind)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    Profile.from_omniauth(@user, request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind:) if is_navigational_format?
    else
      session["devise.auth_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
