class LikesController < ApplicationController
  def create
    @likable = GlobalID::Locator.locate(params[:likable_gid])
    @like = @likable.likes.create(liker_id: current_user.id)

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.turbo_stream
    end
  end

  def destroy
    like = Like.find(params[:id])
    @likable = like.likable
    like.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.turbo_stream
    end
  end
end
