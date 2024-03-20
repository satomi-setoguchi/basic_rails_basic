class BoardsController < ApplicationController
  def index
    @boards = Board.includes(:user)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: t('boards.create.success')
    else
      flash.now[:danger] = t('boards.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
