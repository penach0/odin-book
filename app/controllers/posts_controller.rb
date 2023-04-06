class PostsController < ApplicationController
  def new
    @user = current_user
    @post = Post.new
  end
end
