# -*- encoding: utf-8 -*-
#------------------------------------------------------------------------------
# === クラス概要
#  本クラスは、共通処理コントローラクラスです。
#------------------------------------------------------------------------------
class MenuController < ApplicationController
  skip_before_filter :login_required, :only => [:menu0000, :menu0001]
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  ログイン画面を表示するアクションです
  #----------------------------------------------------------------------------
  def menu0000
     logger.info "-----------------------menu0000 start-----------------------------"
    @user_sessions = UserSession.new
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  ログイン処理を実行するアクションです
  #----------------------------------------------------------------------------
  def menu0001
     logger.info "-----------------------menu0001 start-----------------------------"

    # パラメタの編集
    para             = Hash.new
    para[:login]     = params[:login]
    para[:password]  = params[:password]
    @user_session    = UserSession.new(para)

    # ログイン処理
    if @user_session.save
      # ログイン成功時、権限を取得する
      id_mst = IdMst.where('login_id=?', current_user.login)[0]
      unless id_mst.blank?
         session[:auth] = id_mst.auth_grp
      end
      # デフォルトルートへ遷移
      redirect_to :action => :menu0010
    else
      # ログインエラー時、ログインエラー画面を表示する
      @user_sessions = UserSession.new
      session[:notice] = "login error"
      render :template => 'menu/login_error.html.erb'
    end
  end
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  ログアウト処理を実行するアクションです
  #----------------------------------------------------------------------------
  def menu0002
     logger.info "-----------------------menu0002 start-----------------------------"

    # ログアウト処理
    current_user_session.destroy
  end
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  メニュー画面を表示するアクションです
  #----------------------------------------------------------------------------
  def menu0010
    logger.info "-----------------------menu0010 start-----------------------------"
    logger.debug session[:auth]
    logger.debug "-----------------------------------------------------------------"
    #セッション情報の初期化
    session[:report_date] = nil
    session[:this_year]   = nil
    session[:this_month]  = nil
  end
end
