class BookmarksController < ApplicationController
  def create
    bookmark = Board.find(params[:board_id])
    current_user.bookmark(board)
    redirect_to boards_path, status: :see_other, success: t('defaults.flash_message.bookmark')
  end

  def destroy
    board = current_user.bookmarks.find(params[:id]).board
    current_user.unbookmark(board)
    redirect_to boards_path, status: :see_other, success: t('defaults.flash_message.unbookmark')
  end

  def index
  end

end
