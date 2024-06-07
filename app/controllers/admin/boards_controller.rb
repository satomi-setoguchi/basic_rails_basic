class Admin::BoardsController < Admin::BaseController
  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result.order(created_at: :desc).page(params[:page])
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to admin_board_path(params[:id]), success: t('defaults.flash_message.updated', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: Board.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board= Board.find(params[:id])
    @board.destroy!
    redirect_to admin_boards_path, status: :see_other, success: t('defaults.flash_message.deleted', item: Board.model_name.human)
  end

    private

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
