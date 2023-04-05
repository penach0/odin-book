class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile || @user.build_profile
  end

  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile || @user.create_profile

    if @profile.update(profile_params)
      redirect_to [@user, @profile]
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :date_of_birth, :bio)
    end
end
