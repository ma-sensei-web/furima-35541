class CommentsController < ApplicationController
  # def create
  #   comment = Comment.create(comment_params)
  #   redirect_to item_comments_path(comment.item.id)
  # end

  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.new(comment_params)
    
    if @comment.save
      redirect_to item_path(@item)
    else
      @comments = @item.comments.includes(:user)
      render "items/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
