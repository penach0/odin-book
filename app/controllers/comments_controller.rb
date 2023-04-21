class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @comments = Comment.all
  end

  def show; end

  def new
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
        format.turbo_stream { turbo_stream.append "comments", @comment }
      end
    end
  end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :commenter_id, :commented_post_id)
    end
end
