# -*- encoding: utf-8 -*-
#------------------------------------------------------------------------------
# === クラス概要
#  本クラスは、処理コントローラクラスです。
#------------------------------------------------------------------------------
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  初期画面を表示するアクションです
  #----------------------------------------------------------------------------
  def index
    logger.info "-----------------------Users index start-----------------------------"
    @users = User.where('').paginate(:page => params[:page], :per_page=>15)
    @user = User.new
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  表示画面を表示するアクションです
  #----------------------------------------------------------------------------
  def show
    logger.info "-----------------------Users show start-----------------------------"
    @user = User.find(params[:id])
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  新規画面を表示するアクションです
  #----------------------------------------------------------------------------
  def new
    logger.info "-----------------------Users new start-----------------------------"
    @user = User.new
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def edit
    logger.info "-----------------------Users edit start-----------------------------"
    @user = User.find(params[:id])
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def create
    logger.info "-----------------------Users create start-----------------------------"
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = CmnUtils.get_message("INF001")   #登録処理が完了しました。
      redirect_to :action => :index
    else
      flash[:notice] = "入力エラー：" + @user.errors.full_messages[0];
      render :action => :new
    end
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  更新処理を実行するアクションです
  #----------------------------------------------------------------------------
  def update
    logger.info "-----------------------Users update start-----------------------------"
    if @user.update(user_params)
      flash[:notice] = CmnUtils.get_message("INF001")   #登録処理が完了しました。
      redirect_to :action => :index
    else
      flash[:notice] = "入力エラー：" + @user.errors.full_messages[0];
      render :action => :edit
    end
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  削除処理を実行するアクションです
  #----------------------------------------------------------------------------
  def destroy
    logger.info "-----------------------Users destroy start-----------------------------"
    @user = User.find(params[:id])
    @user.destroy
      redirect_to :action => :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :sex, :birth, :email)
    end

end
