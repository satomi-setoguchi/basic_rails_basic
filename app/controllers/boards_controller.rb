class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]

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

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to @board, success: t('boards.update.success')
    else
      flash.now[:danger] = t('boards.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy!
    redirect_to boards_path, status: :see_other, success: t('boards.destroy.success')
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image)
  end

  def set_board
    @board =current_user.boards.find(params[:id])
  end
end
