class ProfilesController < ApplicationController
  skip_before_action :fill_required_info, only: [:new, :create]
  before_action :set_user
  before_action :set_profile, except: [:new, :create]
  before_action -> { authorize @profile }, only: [:edit, :update]

  def new
    @profile = Profile.new
  end

  def create
    @profile = @user.create_profile(profile_params)

    if @profile.save
      redirect_to user_profile_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

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

    def set_user
      @user = current_user
    end

    def set_profile
      @profile = @user.profile
    end
end
