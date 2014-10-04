# -*- encoding: utf-8 -*-
#------------------------------------------------------------------------------
# === クラス概要
#  本クラスは、処理コントローラクラスです。
#------------------------------------------------------------------------------
<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"
<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  初期画面を表示するアクションです
  #----------------------------------------------------------------------------
  def index
    logger.info "-----------------------<%= controller_class_name %> index start-----------------------------"
    @<%= plural_table_name %> = <%= class_name %>.where('').paginate(:page => params[:page], :per_page=>15)
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  表示画面を表示するアクションです
  #----------------------------------------------------------------------------
  def show
    logger.info "-----------------------<%= controller_class_name %> show start-----------------------------"
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  新規画面を表示するアクションです
  #----------------------------------------------------------------------------
  def new
    logger.info "-----------------------<%= controller_class_name %> new start-----------------------------"
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def edit
    logger.info "-----------------------<%= controller_class_name %> edit start-----------------------------"
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  編集画面を表示するアクションです
  #----------------------------------------------------------------------------
  def create
    logger.info "-----------------------<%= controller_class_name %> create start-----------------------------"
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
    if @<%= orm_instance.save %>
      flash[:notice] = CmnUtils.get_message("INF001")   #登録処理が完了しました。
      redirect_to :action => :index
    else
      flash[:notice] = "入力エラー：" + @<%= singular_table_name %>.errors.full_messages[0];
      render :action => :new
    end
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  更新処理を実行するアクションです
  #----------------------------------------------------------------------------
  def update
    logger.info "-----------------------<%= controller_class_name %> update start-----------------------------"
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      flash[:notice] = CmnUtils.get_message("INF001")   #登録処理が完了しました。
      redirect_to :action => :index
    else
      flash[:notice] = "入力エラー：" + @<%= singular_table_name %>.errors.full_messages[0];
      render :action => :edit
    end
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  削除処理を実行するアクションです
  #----------------------------------------------------------------------------
  def destroy
    logger.info "-----------------------<%= controller_class_name %> destroy start-----------------------------"
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.destroy %>
      redirect_to :action => :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end

end
<% end -%>
