# -*- encoding: utf-8 -*-
#------------------------------------------------------------------------------
# === クラス概要
#  本クラスは、処理コントローラクラスです。
#------------------------------------------------------------------------------
class NameMstsController < ApplicationController
  before_action :set_name_mst, only: [:show, :edit, :update, :destroy]
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  初期画面を表示するアクションです
  #----------------------------------------------------------------------------
  def index
    logger.info "-----------------------NameMsts index start-----------------------------"
    @name_msts = NameMst.where('').paginate(:page => params[:page], :per_page=>20)
    @name_mst = NameMst.new
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  表示画面を表示するアクションです
  #----------------------------------------------------------------------------
  def show
    logger.info "-----------------------NameMsts show start-----------------------------"
    @name_mst = NameMst.find(params[:id])
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  新規画面を表示するアクションです
  #----------------------------------------------------------------------------
  def new
    logger.info "-----------------------NameMsts new start-----------------------------"
    @name_mst = NameMst.new
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def edit
    logger.info "-----------------------NameMsts edit start-----------------------------"
    @name_mst = NameMst.find(params[:id])
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def create
    logger.info "-----------------------NameMsts create start-----------------------------"
    @name_mst = NameMst.new(name_mst_params)
    if @name_mst.save
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
    logger.info "-----------------------NameMsts update start-----------------------------"
    if @name_mst.update(name_mst_params)
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
    logger.info "-----------------------NameMsts destroy start-----------------------------"
    @name_mst = NameMst.find(params[:id])
    @name_mst.destroy
      redirect_to :action => :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_name_mst
      @name_mst = NameMst.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def name_mst_params
      params.require(:name_mst).permit(:code_id, :code_id_name, :code, :name)
    end

end
