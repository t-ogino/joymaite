# -*- encoding: utf-8 -*-
#------------------------------------------------------------------------------
# === クラス概要
#  本クラスは、処理コントローラクラスです。
#------------------------------------------------------------------------------
class GiftMastersController < ApplicationController
  before_action :set_gift_master, only: [:show, :edit, :update, :destroy]
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  初期画面を表示するアクションです
  #----------------------------------------------------------------------------
  def index
    logger.info "-----------------------GiftMasters index start-----------------------------"
    @gift_masters = GiftMaster.where('').paginate(:page => params[:page], :per_page=>20)
    @gift_master = GiftMaster.new
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  表示画面を表示するアクションです
  #----------------------------------------------------------------------------
  def show
    logger.info "-----------------------GiftMasters show start-----------------------------"
    @gift_master = GiftMaster.find(params[:id])
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  新規画面を表示するアクションです
  #----------------------------------------------------------------------------
  def new
    logger.info "-----------------------GiftMasters new start-----------------------------"
    @gift_master = GiftMaster.new
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def edit
    logger.info "-----------------------GiftMasters edit start-----------------------------"
    @gift_master = GiftMaster.find(params[:id])
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def create
    logger.info "-----------------------GiftMasters create start-----------------------------"
    @gift_master = GiftMaster.new(gift_master_params)
    if @gift_master.save
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
    logger.info "-----------------------GiftMasters update start-----------------------------"
    if @gift_master.update(gift_master_params)
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
    logger.info "-----------------------GiftMasters destroy start-----------------------------"
    @gift_master = GiftMaster.find(params[:id])
    @gift_master.destroy
      redirect_to :action => :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift_master
      @gift_master = GiftMaster.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def gift_master_params
      params.require(:gift_master).permit(:div, :condition, :condition_year, :amount, :year_flg)
    end

end
