class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def edit
    comment = Comments.find(params[:id])
  end

  def update
    comment = current_user.comments.find(params[:id])
    if comment.update(comment_params)
      redirect_to board_path(comment), success: t('comment.create.success')
    else
      redirect_to board_path(comment), danger: t('comment.create.failure')
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
