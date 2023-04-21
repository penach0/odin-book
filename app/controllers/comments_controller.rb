class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @comments = Comment.all
  end

  def show; end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def edit; end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.commenter = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = @comment.commented_post
    @comment.update(comment_params)
  end

  def destroy
    @post = @comment.commented_post
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.turbo_stream
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :commenter_id, :commented_post_id)
    end
end
