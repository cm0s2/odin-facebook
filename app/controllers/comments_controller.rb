class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
    redirect_back fallback_location: root_path
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
