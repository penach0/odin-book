class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile || @user.build_profile
  end

  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :date_of_birth, :bio)
    end
end
