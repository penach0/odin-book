class FriendshipsController < ApplicationController
  def create
    friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if friendship.save
      redirect_back(fallback_location: root_path)
    else
      render '/', status: :unprocessable_entity
    end
  end
end
