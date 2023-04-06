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

  def edit
    @user = current_user
    @post = Post.find(params[:id])
  end

  def update
    @user = current_user
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])

    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_path(@user) }
      format.turbo_stream
    end
  end

  private
    def post_params
      params.require(:post).permit(:body)
    end
end
