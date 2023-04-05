class ProfilesController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile || @user.create_profile
  end
end
