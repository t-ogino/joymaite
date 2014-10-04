# -*- encoding: utf-8 -*-
#------------------------------------------------------------------------------
# === クラス概要
#  本クラスは、処理コントローラクラスです。
#------------------------------------------------------------------------------
class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  初期画面を表示するアクションです
  #----------------------------------------------------------------------------
  def index
    logger.info "-----------------------Messages index start-----------------------------"
    @messages = Message.where('').paginate(:page => params[:page], :per_page=>15)
    @message = Message.new
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  表示画面を表示するアクションです
  #----------------------------------------------------------------------------
  def show
    logger.info "-----------------------Messages show start-----------------------------"
    @message = Message.find(params[:id])
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  新規画面を表示するアクションです
  #----------------------------------------------------------------------------
  def new
    logger.info "-----------------------Messages new start-----------------------------"
    @message = Message.new
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def edit
    logger.info "-----------------------Messages edit start-----------------------------"
    @message = Message.find(params[:id])
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def create
    logger.info "-----------------------Messages create start-----------------------------"
    @message = Message.new(message_params)
    if @message.save
      flash[:notice] = CmnUtils.get_message("INF001")   #登録処理が完了しました。
      redirect_to :action => :index
    else
      flash[:notice] = "入力エラー：" + @item.errors.full_messages[0];
      render :action => :new
    end
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  更新処理を実行するアクションです
  #----------------------------------------------------------------------------
  def update
    logger.info "-----------------------Messages update start-----------------------------"
    if @message.update(message_params)
      flash[:notice] = CmnUtils.get_message("INF001")   #登録処理が完了しました。
      redirect_to :action => :index
    else
      flash[:notice] = "入力エラー：" + @item.errors.full_messages[0];
      render :action => :edit
    end
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  削除処理を実行するアクションです
  #----------------------------------------------------------------------------
  def destroy
    logger.info "-----------------------Messages destroy start-----------------------------"
    @message = Message.find(params[:id])
    @message.destroy
      redirect_to :action => :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:msg_code, :message, :upd_uid)
    end

end
