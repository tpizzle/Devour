class Api::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id, :parent_comment_id)
  end
end
