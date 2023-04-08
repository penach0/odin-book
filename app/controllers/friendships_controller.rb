class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:update, :destroy]
  before_action -> { authorize @friendship }, only: [:update, :destroy]

  def create
    friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if friendship.save
      redirect_back(fallback_location: root_path)
    else
      render '/', status: :unprocessable_entity
    end
  end

  def update
    if @friendship.update(friendship_params)
      redirect_back(fallback_location: root_path)
    else
      render '/', status: :unprocessable_entity
    end
  end

  def destroy
    @friendship.destroy

    redirect_back(fallback_location: root_path)
  end

  private
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id, :status)
    end

    def set_friendship
      @friendship = Friendship.find(params[:id])
    end
end
