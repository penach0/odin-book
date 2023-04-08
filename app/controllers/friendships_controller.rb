class FriendshipsController < ApplicationController
  def create
    friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if friendship.save
      redirect_back(fallback_location: root_path)
    else
      render '/', status: :unprocessable_entity
    end
  end

  def update
    friendship = Friendship.find(params[:id])
    authorize friendship

    if friendship.update(friendship_params)
      redirect_back(fallback_location: root_path)
    else
      render '/', status: :unprocessable_entity
    end
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy

    redirect_back(fallback_location: root_path)
  end

  private
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id, :status)
    end
end
