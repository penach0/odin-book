class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = @user.created_posts.build
  end

  def create
    @user = current_user
    @post = @user.created_posts.create(post_params)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def post_params
      params.require(:post).permit(:body)
    end
end