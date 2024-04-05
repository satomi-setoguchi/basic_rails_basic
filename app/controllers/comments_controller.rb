class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to board_path(comment.board), success: t('comment.create.success')
    else
      redirect_to board_path(comment.board), danger: t('comment.create.failure')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
