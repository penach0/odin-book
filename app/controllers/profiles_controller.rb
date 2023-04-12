class ProfilesController < ApplicationController
  before_action :set_variables
  before_action -> { authorize @profile }, only: [:edit, :update]

  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to user_profile_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :date_of_birth, :bio)
    end

    def set_variables
      @user = User.find(params[:user_id])
      @profile = @user.profile
    end
end
