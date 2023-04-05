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
    friendship = Friendship.find(user_id: params[:user_id], friend_id: current_user.id)
    case params[:action]
    when 'accept'
      friendship.accepted!
    when 'reject'
      friendship.rejected!
    end

    if friendship.save
      redirect_back(fallback_location: root_path)
    else
      render '/', status: :unprocessable_entity
    end
  end
end
