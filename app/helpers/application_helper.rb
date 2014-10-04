# -*- encoding: utf-8 -*-
module ApplicationHelper
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 終了ボタンを押された場合の戻りurl（メニューへの遷移）を取得します。
  # === 引数
  #  なし
  # === 戻り値
  #  戻り  url
  #------------------------------------------------------------------------------------------------
  def back_menu_url
#    return url_for()
     return '/menu/menu0010'
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # カンマ区切りされた数値文字列を返します。
  #
  # === 引数
  # +num+:: 変換する数値
  #
  # === 戻り値
  # カンマ区切りされた数値文字列
  #
  #------------------------------------------------------------------------------------------------
  def get_disp_number(num)
    return num.to_s.gsub(/(\d)(?=(?:\d\d\d)+(?!\d))/, '\1,')
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  #  改行コードを<BR>に変換します
  # === 引数
  #  str      : 変換対象値
  # === 戻り値
  #  変換後値
  #
  #------------------------------------------------------------------------------------------------
  def to_br(str)
    str = html_escape(str)
    sanitize(raw(str.gsub(/\r\n|\r|\n/, "<br />")))
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  #  
  # === 引数
  #  str      : 変換対象値
  # === 戻り値
  #  変換後値
  #
  #------------------------------------------------------------------------------------------------
  def make_date_select(f,str, bol_blank)
     if bol_blank == true
       raw(sprintf(f.date_select(:"#{str}", :include_blank => true, :use_month_numbers=>true,:date_separator =>'%s'),'年', '月') + '日')
       #raw(sprintf(f.date_select(:"#{str}", :include_blank => true, :use_month_numbers=>true,:date_separator =>'%s'),'年', '月') + '日') エラーの時、日が赤にならない
       #raw(sprintf(f.date_select(:"#{str}", :include_blank => true, :use_month_numbers=>true,:date_separator =>'%s'),'／', '／') + '')
     else
       raw(sprintf(f.date_select(:"#{str}", :include_blank => false, :use_month_numbers=>true,:date_separator =>'%s'),'年', '月') + '日')
     end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  #  
  # === 引数
  #  str      : 変換対象値
  # === 戻り値
  #  変換後値
  #
  #------------------------------------------------------------------------------------------------
  def make_date_select2(str1, str2, bol_blank)
     if bol_blank == true
       raw(sprintf(date_select(str1, str2, :include_blank => true, :use_month_numbers=>true,:date_separator =>'%s'),'年', '月') + '日')
     else
       raw(sprintf(date_select(str1, str2, :include_blank => false, :use_month_numbers=>true,:date_separator =>'%s'),'年', '月') + '日')
     end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  #  
  # === 引数
  #  str      : 変換対象値
  # === 戻り値
  #  変換後値
  #
  #------------------------------------------------------------------------------------------------
  def make_date_select_yymm(f,str, bol_blank)
     if bol_blank == true
       raw(sprintf(f.date_select(:"#{str}", :include_blank => true,  :use_month_numbers=>true,:discard_day=>true,:date_separator =>'%s'),'年') + '月')
     else
       raw(sprintf(f.date_select(:"#{str}", :include_blank => false, :use_month_numbers=>true,:discard_day=>true,:date_separator =>'%s'),'年') + '月')
     end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  #  
  # === 引数
  #  str      : 変換対象値
  # === 戻り値
  #  変換後値
  #
  #------------------------------------------------------------------------------------------------
  def make_date_select_yymm2(str1,str2, bol_blank)
     if bol_blank == true
       raw(sprintf(date_select(str1, str2, :include_blank => true,  :use_month_numbers=>true,:discard_day=>true,:date_separator =>'%s'),'年') + '月')
     else
       raw(sprintf(date_select(str1, str2, :include_blank => false, :use_month_numbers=>true,:discard_day=>true,:date_separator =>'%s'),'年') + '月')
     end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  #  
  # === 引数
  #  str      : 変換対象値
  # === 戻り値
  #  変換後値
  #
  #------------------------------------------------------------------------------------------------
  def make_date_select_yymm3(str1,str2,date,bol_blank)
     if bol_blank == true
       raw(sprintf(date_select(str1, str2, :include_blank => true,  :use_month_numbers=>true,:discard_day=>true,:date_separator =>'%s',:default=>date),'年') + '月')
     else
       raw(sprintf(date_select(str1, str2, :include_blank => false, :use_month_numbers=>true,:discard_day=>true,:date_separator =>'%s',:default=>date),'年') + '月')
     end
  end
#--------------------------------------------------------------------------------------------------
# ＳＥＬＥＣＴタグ生成
#--------------------------------------------------------------------------------------------------
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 金融機関選択用のSELECTタグを取得します。
  # === 引数
  #  name:               SELECTタグのname属性
  #  options:            オプション
  # ==== オプションが受け付ける値
  #  include_blank:      trueの場合、未選択用の選択肢<option value="0"></option>を追加する
  # === 戻り値
  #  選択用のSELECTタグ
  #------------------------------------------------------------------------------------------------
  def bank_select_tag(name, options = {})

    # 選択のオプション要素を生成する
    option_array = []

    #ＤＢ読込
    banks = Bank.order('bank_code')
    banks.each do |bank|
#       option_array << [bank.bank_code + '  ' + bank.name, bank.bank_code]
       option_array << [bank.name, bank.bank_code]
    end

    #SELECTタグ生成
    make_select_tag(name, option_array, options)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # プロジェクト選択用のSELECTタグを取得します。
  # === 引数
  #  name:               SELECTタグのname属性
  #  options:            オプション
  # ==== オプションが受け付ける値
  #  include_blank:      trueの場合、未選択用の選択肢<option value="0"></option>を追加する
  # === 戻り値
  #  選択用のSELECTタグ
  #------------------------------------------------------------------------------------------------
  def project_select_tag(name, options = {})

    # 選択のオプション要素を生成する
    option_array = []

    #ＤＢ読込
    projects = Project.order('project_id')
    projects.each do |project|
       option_array << [project.project_name, project.project_id]
    end

    #SELECTタグ生成
    make_select_tag(name, option_array, options)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # プロジェクト選択用のSELECTタグを取得します。
  # === 引数
  #  name:               SELECTタグのname属性
  #  options:            オプション
  # ==== オプションが受け付ける値
  #  include_blank:      trueの場合、未選択用の選択肢<option value="0"></option>を追加する
  # === 戻り値
  #  選択用のSELECTタグ
  #------------------------------------------------------------------------------------------------
  def client_select_tag(name, options = {})

    # 選択のオプション要素を生成する
    option_array = []

    #ＤＢ読込
    clients = Client.order('client_id')
    clients.each do |client|
       option_array << [client.client_name, client.client_id]
    end

    #SELECTタグ生成
    make_select_tag(name, option_array, options)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # プロジェクト選択用のSELECTタグを取得します。
  # === 引数
  #  name:               SELECTタグのname属性
  #  options:            オプション
  # ==== オプションが受け付ける値
  #  include_blank:      trueの場合、未選択用の選択肢<option value="0"></option>を追加する
  # === 戻り値
  #  選択用のSELECTタグ
  #------------------------------------------------------------------------------------------------
  def staff_select_tag(name, options = {})

    # 選択のオプション要素を生成する
    option_array = []

    #ＤＢ読込
    staffs = Staff.order('staff_no')
    staffs.each do |staff|
       option_array << [staff.name, staff.staff_no]
    end

    #SELECTタグ生成
    make_select_tag(name, option_array, options)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 元号選択用のSELECTタグを取得します。（元号取得関数作成までの暫定版）
  # === 引数
  #  name:               SELECTタグのname属性
  #  options:            オプション
  # ==== オプションが受け付ける値
  #  include_blank:      trueの場合、未選択用の選択肢<option value="0"></option>を追加する
  # === 戻り値
  #  選択用のSELECTタグ
  #------------------------------------------------------------------------------------------------
  def era_select_tag(name, options = {})

    # 選択のオプション要素を生成する
    option_array = []

    #オプション欄作成
    option_array << ['平成', '4']

    #SELECTタグ生成
    make_select_tag(name, option_array, options)

  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 月選択用のSELECTタグを取得します。
  # === 引数
  #  name:               SELECTタグのname属性
  #  options:            オプション
  # ==== オプションが受け付ける値
  #  include_blank:      trueの場合、未選択用の選択肢<option value="0"></option>を追加する
  # === 戻り値
  #  選択用のSELECTタグ
  #------------------------------------------------------------------------------------------------
  def month_select_tag(name, options = {})

    # 選択のオプション要素を生成する
    option_array = []

    #オプション欄作成
    option_array << ['4月',  '04']
    option_array << ['5月',  '05']
    option_array << ['6月',  '06']
    option_array << ['7月',  '07']
    option_array << ['8月',  '08']
    option_array << ['9月',  '09']
    option_array << ['10月', '10']
    option_array << ['11月', '11']
    option_array << ['12月', '12']
    option_array << ['1月',  '01']
    option_array << ['2月',  '02']
    option_array << ['3月',  '03']

    #SELECTタグ生成
    make_select_tag(name, option_array, options)

  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 月選択用のSELECTタグを取得します。
  # === 引数
  #  name:               SELECTタグのname属性
  #  options:            オプション
  # ==== オプションが受け付ける値
  #  include_blank:      trueの場合、未選択用の選択肢<option value="0"></option>を追加する
  # === 戻り値
  #  選択用のSELECTタグ
  #------------------------------------------------------------------------------------------------
  def mon_kbn_select_tag(name, options = {})

    # 選択のオプション要素を生成する
    option_array = []

    #オプション欄作成
    option_array << ['上期',  '1']
    option_array << ['下期',  '2']

    #SELECTタグ生成
    make_select_tag(name, option_array, options)

  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # SELECTタグを生成します。（各種のタグから呼ばれる共通処理）
  # === 引数
  #  name:               SELECTタグのname属性
  #  options:            オプション
  # ==== オプションが受け付ける値
  #  include_blank:      trueの場合、未選択用の選択肢<option value="0"></option>を追加する
  # === 戻り値
  #  選択用のSELECTタグ
  #------------------------------------------------------------------------------------------------
  def make_select_tag(name, option_array = {}, options = {})

    # 未選択用の選択肢を追加する
    if options[:include_blank]
      option_array.insert(0, ["", 0])
    end

    # オプションの整形（不要な要素を取り除く）
    options.delete(:include_blank)
    options.delete(:read_only)
    options.delete(:era_start)

    # SELECTタグヘルパーによる選択用のSELECTタグ生成
    select_tag(name,
               options_for_select(option_array, options[:value]),
               options)
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 相手科目選択用のSELECTタグを取得します。
  # === 引数
  #  name:               SELECTタグのname属性
  #  options:            オプション
  # ==== オプションが受け付ける値
  #  include_blank:      trueの場合、未選択用の選択肢<option value="0"></option>を追加する
  # === 戻り値
  #  選択用のSELECTタグ
  #------------------------------------------------------------------------------------------------
  def item_select_tag(name, options = {})
    #SELECTタグ生成
    make_name_select_tag(CODE_ID_ITEM, name, options)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 相手科目選択用のSELECTタグを取得します。
  # === 引数
  #  name:               SELECTタグのname属性
  #  options:            オプション
  # ==== オプションが受け付ける値
  #  include_blank:      trueの場合、未選択用の選択肢<option value="0"></option>を追加する
  # === 戻り値
  #  選択用のSELECTタグ
  #------------------------------------------------------------------------------------------------
  def certify_kbn_select_tag(name, options = {})
    #SELECTタグ生成
    make_name_select_tag(CODE_ID_CERTIFY_DIV, name, options)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # SELECTタグを取得します。（名称テーブルから作成する共通処理）
  # === 引数
  #  code_id:            コード種類
  #  name:               SELECTタグのname属性
  #  options:            オプション
  # ==== オプションが受け付ける値
  #  include_blank:      trueの場合、未選択用の選択肢<option value="0"></option>を追加する
  # === 戻り値
  #  選択用のSELECTタグ
  #------------------------------------------------------------------------------------------------
  def make_name_select_tag(code_id, name, options = {})

    # 選択のオプション要素を生成する
    option_array = []
    #ＤＢ読込
    name_mstes = NameMst.where('code_id=?', code_id).order('code')
    name_mstes.each do |name_mst|
#       option_array << [name_mst.code + '  ' + name_mst.name, name_mst.code]
       option_array << [name_mst.name, name_mst.code]
    end
    #SELECTタグ生成
    make_select_tag(name, option_array, options)
  end
#--------------------------------------------------------------------------------------------------
# 名称取得
#--------------------------------------------------------------------------------------------------
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 社員名を取得する
  # === 引数
  #  staff_no:           社員番号
  # === 戻り値
  #  戻り                社員名
  #------------------------------------------------------------------------------------------------
  def get_staff_name(staff_no)
    if staff_no.blank?
      return ''
    end
    staff = Staff.where('staff_no=?', staff_no)[0]
    if staff.blank?
      return ''
    else
      return staff.name
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 資格名を取得する
  # === 引数
  #  certify_id:         資格ID
  # === 戻り値
  #  戻り                資格名
  #------------------------------------------------------------------------------------------------
  def get_certify_mst_name(certify_id)
    if certify_id.blank?
      return ''
    end
    certify_mst = CertifyMst.where('certify_id=?', certify_id)[0]
    if certify_mst.blank?
      return ''
    else
      return certify_mst.certify_name
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 金融機関コードに対応する名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_bank_name(code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    bank = Bank.where('bank_code=?', code)[0]
    if bank.blank?
      return ''
    else
      return bank.name
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # プロジェクトコードに対応する名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_project_name(code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    project = Project.where('project_id=?', code)[0]
    if project.blank?
      return ''
    else
      return project.project_name
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 取引先コードに対応する名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_client_name(code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    client = Client.where('client_id=?', code)[0]
    if client.blank?
      return ''
    else
      return client.client_name
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 取引先コードに対応する略称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_client_rname(code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    client = Client.where('client_id=?', code)[0]
    if client.blank?
      return ''
    else
      return client.client_rname
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # メッセージコードに対応する名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_message(code)
    if code.blank?
      return ''
    end
    message = Message.where('msg_code=?', code)[0]
    if message.blank?
      return code
    else
      return message.message
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 相手科目に対応する名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_item_name(code)
    get_name(CODE_ID_ITEM, code)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 資格区分に対応する名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_certify_kbn_name(code)
    get_name(CODE_ID_CERTIFY_DIV, code)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 名称を取得します。（共通処理）
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_name(code_id, code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    name_mst = NameMst.where('code_id=? and code=?', code_id, code)[0]
    if name_mst.blank?
      return ''
    else
      return name_mst.name
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 有無に対応する記号を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_umu_mark(code)
#    if code.blank?
#      return ''
    if code == true
      return '○'     
    elsif code == false
      return '×'     
    else
      return ''     
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 表示用時刻に編集します。
  # === 引数
  #  time:               時刻
  # === 戻り値
  #  表示用時刻
  #------------------------------------------------------------------------------------------------
  def get_disp_time(time)
    if time.blank?
      return ''
    end
    return time.strftime("%H:%M")
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 表示用時刻に編集します。
  # === 引数
  #  time:               時刻
  # === 戻り値
  #  表示用時刻
  #------------------------------------------------------------------------------------------------
  def get_disp_ym(date)
    if date.blank?
      return ''
    end
    return date.strftime("%Y年%m月") 
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 表示用時刻に編集します。
  # === 引数
  #  time:               時刻
  # === 戻り値
  #  表示用時刻
  #------------------------------------------------------------------------------------------------
  def get_wdate_name(date)
    if date.blank?
      return ''
    end
    wdays = ["日", "月", "火", "水", "木", "金", "土"]
    return "(" + wdays[date.wday] + ")"
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 曜日名を取得します。
  # === 引数
  #  date:              日付
  # === 戻り値
  #  曜日名
  #------------------------------------------------------------------------------------------------
  def get_wdate_color(date)
    if date.blank?
      return ''
    end
    wdays = ["red", "black", "black", "black", "black", "black", "blue"]
    return wdays[date.wday]
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 一覧表のclassを取得します
  # === 引数
  #  cnt:             行数
  # === 戻り値
  #  使用するclass
  #------------------------------------------------------------------------------------------------
  def get_td_class(cnt)
    return "tbl_data" if (cnt % 2) == 1
    return "tbl_data_skyblue" if (cnt % 2) != 1
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 帰社報告情報を取得する
  # === 引数
  #  staff_no:           社員番号
  # === 戻り値
  #  戻り                帰社報告の状態
  #------------------------------------------------------------------------------------------------
  def get_month_report_status(staff_no, today)
      return CmnUtils.get_month_report_status(staff_no, today)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 帰社報告情報を取得する
  # === 引数
  #  staff_no:           社員番号
  # === 戻り値
  #  戻り                帰社報告の状態名
  #------------------------------------------------------------------------------------------------
  def get_month_report_status_name(staff_no, today)
      status = CmnUtils.get_month_report_status(staff_no, today)
      return '入力完了' if status == MONTH_REPORT_STATUS_DONE
      return '入力中'   if status == MONTH_REPORT_STATUS_INIT
      return '未入力' 
  end
  def hbr(str)
    str = html_escape(str)
    str.gsub(/\r\n|\r|\n/, "<br />")
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 年数を計算する
  # === 引数
  #  calc_date:           計算する日付
  # === 戻り値
  #  戻り                年数
  #------------------------------------------------------------------------------------------------
  def get_nen(calc_date = Time.now)
    if calc_date.blank?
      return 0
    end
    (Time.now.strftime("%Y%m%d").to_i - calc_date.strftime("%Y%m%d").to_i)/10000
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 永年勤続報奨金取得
  # === 引数
  #  calc_nen:           計算する年数
  # === 戻り値
  #  戻り                取得情報
  #------------------------------------------------------------------------------------------------
  def get_gift_kinzoku(calc_nen = 0)
    giftmaster = GiftMaster.where('gift_div=? and condition_year=? and year_flg=?','1', calc_nen, '1')[0]
    if giftmaster.blank?
      return ''
    else
      return giftmaster.condition + '　' + giftmaster.amount
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 結婚祝い金取得
  # === 引数
  #  calc_nen:           計算する年数
  # === 戻り値
  #  戻り                取得情報
  #------------------------------------------------------------------------------------------------
  def get_gift_marry(calc_nen = 0)
    giftmaster = GiftMaster.where('gift_div=? and condition_year=? and year_flg=?','2', calc_nen, '1')[0]
    if giftmaster.blank?
      return ''
    else
      return giftmaster.condition + '　' + giftmaster.amount
    end
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 永年勤続報奨金取得
  # === 引数
  #  calc_nen:           計算する年数
  # === 戻り値
  #  戻り                有無印
  #------------------------------------------------------------------------------------------------
  def get_gift_kinzoku_mark(calc_nen = 0)
    giftmaster = GiftMaster.where('gift_div=? and condition_year=? and year_flg=?','1', calc_nen, '1')[0]
    if giftmaster.blank?
      return ''
    else
      return '★'
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 結婚祝い金取得
  # === 引数
  #  calc_nen:           計算する年数
  # === 戻り値
  #  戻り                有無印
  #------------------------------------------------------------------------------------------------
  def get_gift_marry_mark(calc_nen = 0)
    giftmaster = GiftMaster.where('gift_div=? and condition_year=? and year_flg=?','2', calc_nen, '1')[0]
    if giftmaster.blank?
      return ''
    else
      return '★'
    end
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 次回永年勤続報奨金取得
  # === 引数
  #  calc_nen:           計算する年数
  # === 戻り値
  #  戻り                次回年、取得情報
  #------------------------------------------------------------------------------------------------
  def get_gift_kinzoku_next(calc_date = Time.now)
    calc_nen = get_nen(calc_date)
    for i in 0..100 do
      giftmaster = GiftMaster.where('gift_div=? and condition_year=? and year_flg=?','1', calc_nen, '1')[0]
      if giftmaster.blank?
        calc_nen += 1
      else
        next_day = Date.new(Time.now.year+i, calc_date.month, calc_date.day)
        return next_day , giftmaster.condition + '　' + giftmaster.amount
      end
    end
    return "",""
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 次回結婚祝い金取得
  # === 引数
  #  calc_nen:           計算する年数
  # === 戻り値
  #  戻り                年数
  #------------------------------------------------------------------------------------------------
  def get_gift_marry_next(calc_date = Time.now)
    if calc_date.blank?
      return "",""
    end
    calc_nen = get_nen(calc_date)
    for i in 0..100 do
      giftmaster = GiftMaster.where('gift_div=? and condition_year=? and year_flg=?','2', calc_nen, '1')[0]
      if giftmaster.blank?
        calc_nen += 1
        calc_date = calc_date.years_since(1)
      else
        next_day = Date.new(Time.now.year+i, calc_date.month, calc_date.day)
        return next_day , giftmaster.condition + '　' + giftmaster.amount
      end
    end
    return "",""
  end
end
