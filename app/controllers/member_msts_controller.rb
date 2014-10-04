# -*- encoding: utf-8 -*-
#------------------------------------------------------------------------------
# === クラス概要
#  本クラスは、処理コントローラクラスです。
#------------------------------------------------------------------------------
class MemberMstsController < ApplicationController
  before_action :set_member_mst, only: [:show, :edit, :update, :destroy]
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  初期画面を表示するアクションです
  #----------------------------------------------------------------------------
  def index
    logger.info "-----------------------MemberMsts index start-----------------------------"
    @member_msts = MemberMst.order('menber_no').paginate(:page => params[:page], :per_page=>20)
    @member_mst = MemberMst.new
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  表示画面を表示するアクションです
  #----------------------------------------------------------------------------
  def show
    logger.info "-----------------------MemberMsts show start-----------------------------"
    @member_mst = MemberMst.find(params[:id])
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  新規画面を表示するアクションです
  #----------------------------------------------------------------------------
  def new
    logger.info "-----------------------MemberMsts new start-----------------------------"
    @member_mst = MemberMst.new
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def edit
    logger.info "-----------------------MemberMsts edit start-----------------------------"
    @member_mst = MemberMst.find(params[:id])
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def create
    logger.info "-----------------------MemberMsts create start-----------------------------"
    @member_mst = MemberMst.new(member_mst_params)
    if @member_mst.save
      flash[:notice] = CmnUtils.get_message("INF001")   #登録処理が完了しました。
      redirect_to :action => :index
    else
      flash[:notice] = "入力エラー：" + @member_mst.errors.full_messages[0];
      render :action => :new
    end
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  更新処理を実行するアクションです
  #----------------------------------------------------------------------------
  def update
    logger.info "-----------------------MemberMsts update start-----------------------------"
    if @member_mst.update(member_mst_params)
      flash[:notice] = CmnUtils.get_message("INF001")   #登録処理が完了しました。
      redirect_to :action => :index
    else
      flash[:notice] = "入力エラー：" + @member_mst.errors.full_messages[0];
      render :action => :edit
    end
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  削除処理を実行するアクションです
  #----------------------------------------------------------------------------
  def destroy
    logger.info "-----------------------MemberMsts destroy start-----------------------------"
    @member_mst = MemberMst.find(params[:id])
    @member_mst.destroy
      redirect_to :action => :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member_mst
      @member_mst = MemberMst.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def member_mst_params
      params.require(:member_mst).permit(:menber_no, :menber_name, :admission_date, :withdrawal_date, :birth_date, :enter_date, :marry_date, :memo, :del_flg)
    end

end
