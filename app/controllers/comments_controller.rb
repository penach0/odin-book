class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_post, except: :edit
  before_action -> { authorize @comment }, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
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

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_back(fallback_location: root_path)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: user_posts_path(current_user)) }
      format.turbo_stream
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_commentable
      @commentable = (@comment ? @comment.commentable : Post.find(params[:post_id]))
    end

    def comment_params
      params.require(:comment).permit(:body, :commenter_id, :commentable_tye, :commentable_id)
    end
end
