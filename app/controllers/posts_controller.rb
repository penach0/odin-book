class PostsController < ApplicationController
  before_action :set_user, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action -> { authorize @post }, only: [:edit, :update, :destroy]

  def index
    @posts = Post.with_info(:latest_comment).ordered
  end

  def show
    @post = Post.with_info(:comments).find(params[:id])
  end

  def new
    @post = @user.created_posts.build
  end

  def create
    @post = @user.created_posts.create(post_params)

    if @post.save
      respond_to do |format|
        format.html { redirect_to @post }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
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

    def set_user
      @user = current_user
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
