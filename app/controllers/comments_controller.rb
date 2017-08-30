class CommentsController < ApplicationController
  before_action :require_logged_in

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      if @comment.parent_comment_id.nil?
        redirect_to post_url(@comment.post_id)
      else
        redirect_to comment_url(@comment.parent_comment_id)
      end
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_post_comment_url(@comment.post_id)
    end
  end

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
