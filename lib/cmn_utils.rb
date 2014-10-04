# -*- encoding: utf-8 -*-
module CmnUtils

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 指定日が営業日か否かを判定し、非営業日の場合には、直近の営業日を返却する
  # === 引数
  #  date:             指定日
  # === 戻り値
  #  指定日、指定日が営業日でない場合、直近の営業日
  #------------------------------------------------------------------------------------------------
  def get_business_date(date)
    if date.blank?
      return nil
    end
    while not_business_day?(date)
       date = date + 1
    end
    return date
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 該当日が休日か否かを判定します
  # === 引数
  #  date:             判定日
  # === 戻り値
  #  true:休日  false:平日
  #------------------------------------------------------------------------------------------------
  def not_business_day?(date)
    if date.blank?
      return false
    end
    # 曜日の判定（土曜か日曜か）
    if date.wday == 6 || date.wday == 0
      return true
    end
    #ＤＢ読込
    holiday = HolidayMst.where('holiday=?', date)[0]
    if holiday.blank?
      return false
    else
      return true
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 該当日が休日か否かを判定します
  # === 引数
  #  date:             判定日
  # === 戻り値
  #  true:休日  false:平日
  #------------------------------------------------------------------------------------------------
  def holiday?(date)
    if date.blank?
      return false
    end
    #ＤＢ読込
    holiday = HolidayMst.where('holiday=?', date)[0]
    if holiday.blank?
      return false
    else
      return true
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 見積番号を取得します
  # === 引数
  #  user_dept:           部署コード
  #  userid:              担当者コード
  # === 戻り値
  #  見積番号
  #------------------------------------------------------------------------------------------------
  def get_receipt_no(user_dept, userid)

    #number_key = user_dept + userid + Date.today.strftime("%y")
    #number_key = Date.today.strftime("%y") + userid 

    number_key = Date.today.strftime("%y") + user_dept
    number = Number.where('number_key=?', number_key)[0]
    if number.blank?
      number = Number.new
      number.number_name  = '見積番号'
      number.number_key   = number_key
      number.number_value = '0000'
    end
    number.number_value = sprintf("%04d", number.number_value.to_i + 1)
    number.save!
    return number_key + number.number_value
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 発注番号を取得します
  # === 引数
  #  user_dept:           部署コード
  #  userid:              担当者コード
  # === 戻り値
  #  発注番号
  #------------------------------------------------------------------------------------------------
  def get_order_no(user_dept, userid)

    #number_key = '0-' + user_dept + userid + Date.today.strftime("%y")
    #number_key = '0-' + Date.today.strftime("%y") + userid

    number_key = '0-' + Date.today.strftime("%y") + user_dept
    number = Number.where('number_key=?', number_key)[0]
    if number.blank?
      number = Number.new
      number.number_name  = '発注番号'
      number.number_key   = number_key
      number.number_value = '0000'
    end
    number.number_value = sprintf("%04d", number.number_value.to_i + 1)
    number.save!
    return number_key + number.number_value
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 納品番号を取得します
  # === 引数
  #  user_dept:           部署コード
  #  userid:              担当者コード
  # === 戻り値
  #  発注番号
  #------------------------------------------------------------------------------------------------
  def get_deliver_no(user_dept, userid)

    #number_key = 'D-' + user_dept + userid + Date.today.strftime("%y")
    #number_key = 'D-' + Date.today.strftime("%y")+ userid

    number_key = 'D-' + Date.today.strftime("%y") + user_dept
    number = Number.where('number_key=?', number_key)[0]
    if number.blank?
      number = Number.new
      number.number_name  = '納品番号'
      number.number_key   = number_key
      number.number_value = '0000'
    end
    number.number_value = sprintf("%04d", number.number_value.to_i + 1)
    number.save!
    return number_key + number.number_value
  end
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
  # 担当者の所属部署を取得する
  # === 引数
  #  staff_no:           担当者番号
  # === 戻り値
  #  戻り                部署コード
  #------------------------------------------------------------------------------------------------
  def get_dept(staff_no)
    if staff_no.blank?
      return ''
    end
    staff = Staff.where('staff_no=?', staff_no)[0]
    if staff.blank?
      return ''
    else
      return staff.dept
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 金額からカンマを削除します
  # === 引数
  #  money:              カンマ付金額
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_money(money)
    if money.blank?
      return ''
    end
    return money.gsub(',','')
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
  # カンマ区切りされた数値文字列を返します。
  #
  # === 引数
  # +num+:: 変換する数値
  #
  # === 戻り値
  # カンマ区切りされた数値文字列
  #
  #------------------------------------------------------------------------------------------------
  def get_disp_percent(num)
    if num.blank?
      return ""
    end
    return sprintf( "%.2f",num*100) + '%'
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
  def get_disp_date(date)
    if date.blank?
      return ''
    end
    return date.strftime("%Y年%m月%d日") 
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
      return client.name
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
      return client.rname
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 取引先コードに対応する補助名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_client_sub_name(code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    client = Client.where('client_id=?', code)[0]
    if client.blank?
      return ''
    else
      return client.sub_name
    end
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 得意先コードに対応する名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_customer_name(code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    customer = Customer.where('client_id=?', code)[0]
    if customer.blank?
      return ''
    else
      return customer.name
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 得意先コードに対応する略称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_customer_rname(code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    customer = Customer.where('client_id=?', code)[0]
    if customer.blank?
      return ''
    else
      return customer.rname
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 取引先コードに対応する補助名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_customer_sub_name(code)
    if code.blank?
      return ''
    end
      return ''
=begin
    #ＤＢ読込
    client = Client.where('client_id=?', code)[0]
    if client.blank?
      return ''
    else
      return client.sub_name
    end
=end
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 仕入先コードに対応する名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_provider_name(code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    provider = Provider.where('client_id=?', code)[0]
    if provider.blank?
      return ''
    else
      return provider.name
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 仕入先コードに対応する略称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_provider_rname(code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    provider = Provider.where('client_id=?', code)[0]
    if provider.blank?
      return ''
    else
      return provider.rname
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 取引先コードに対応する補助名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_provider_sub_name(code)
    if code.blank?
      return ''
    end
      return ''
=begin
    #ＤＢ読込
    client = Client.where('client_id=?', code)[0]
    if client.blank?
      return ''
    else
      return client.sub_name
    end
=end
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 自社名を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_company_name()
    #ＤＢ読込
    company = Company.all[0]
    if company.blank?
      return ''
    else
      return company.name
    end
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 科目コードに対応する名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_item_name(code)
    if code.blank?
      return ''
    end
    item = Item.where('item_id=?', code)[0]
    if item.blank?
      return code
    else
      return item.name
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
    bank = Bank.where('bank_id=?', code)[0]
    if bank.blank?
      return code
    else
      return bank.name
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 金融機関コードに対応するカナ名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_bank_kananame(code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    bank = Bank.where('bank_id=?', code)[0]
    if bank.blank?
      return code
    else
      return bank.kname
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 金融機関コードに対応する印刷用名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_bank_prname(code)
    if code.blank?
      return ''
    end
    #ＤＢ読込
    bank = Bank.where('bank_id=?', code)[0]
    if bank.blank?
      return code
    else
      return bank.pr_name
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 金融機関コード・支店コードに対応する名称を取得します。
  # === 引数
  #  code:               コード
  # === 戻り値
  #  コードに対する名称
  #------------------------------------------------------------------------------------------------
  def get_branch_name(bank_id, branch_id)
    if bank_id.blank?
      return ''
    end
    if branch_id.blank?
      return ''
    end
    #ＤＢ読込
    branch = Branch.where('bank_id=? and branch_id=?', bank_id, branch_id)[0]
    if branch.blank?
      return branch_id
    else
      return branch.name
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 口振依頼連番を取得します。
  # === 引数
  #  no:               一連番号
  # === 戻り値
  #  一連番号＋c/d
  #------------------------------------------------------------------------------------------------
  def get_furi_renban(no)
    if no.blank?
      return ''
    end
    str_no = sprintf("%05d",no)
    # チェックデジット算出
    check_digit = SnaCheckD.get_check_digit(str_no)
    return  str_no + check_digit
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
    if code == '000000'
      return '正常終了'
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
  #  配列として作成されたCSVデータを改行コードで連結した文字列に変換します。
  # === 引数
  #  csv_array: 配列データ
  # === 戻り値
  #  各配列を改行コードで連結した文字列
  #------------------------------------------------------------------------------------------------
  def convert_csv_data(csv_array)
    # 配列のデータを改行コードで区切られた文字列データに変換します。
    str = ""
    csv_array.each do |row|
      str.concat(row.join(",") + "\n")
    end
    return str
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 名称を取得します。（共通処理）
  # === 引数
  #  code_id:            コードID
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
  #  固定長レコード編集（数字）
  # === 引数
  #    record 設定先文字列
  #    pos    設定開始位置
  #    len    文字列長
  #    str    設定する文字
  # === 戻り値
  #  固定長レコード
  #------------------------------------------------------------------------------------------------
  def set_fixed_rec_num(record, pos, len, str)
    return record[pos, len] =  sprintf("%0#{len}d",str.to_i)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  #  固定長レコード編集（文字列）
  # === 引数
  #    record 設定先文字列
  #    str    設定文字列
  #    pos    設定開始位置
  #    len    文字列長
  #    str    設定する文字
  # === 戻り値
  #  固定長レコード
  #------------------------------------------------------------------------------------------------
  def set_fixed_rec_str(record, pos, len, str)
    return record[pos, len] =  edit_fixed_str(str, len)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  #  項目固定長編集（文字列） 
  # === 引数
  #    str 変換対象文字列
  #    len 文字列長
  # === 戻り値
  #  固定長文字列
  #------------------------------------------------------------------------------------------------
  def edit_fixed_str(str, len)
    # 入力値がnilの場合
    str = ''  if str == nil
    # 指定文字列長と等しい場合、そのまま返却する
    if str.length == len
       return str
    end 
    # 指定文字列長より大きい場合、指定文字列長分返却する
    if str.length > len
       return str[0, len]
    end 
    # 指定文字列長より小さい場合、ＳＰＡＣＥを補って返却する
    if str.length < len
       return str + ' ' * (len - str.length)
    end 
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # バッチ依頼メッセージをバッチログに出力する
  # === 引数
  #  job_id:              バッチジョブＩＤ
  # === 戻り値
  #  なし
  #------------------------------------------------------------------------------------------------
  def set_batch_req_message(job_id)
    # ログ
    #logger     = Logger.new(File.join(Rails.root.to_s, "log", "batch.log"), 'daily')
    logger     = Logger.new(File.join(Rails.root.to_s, "log", "batch.log"))
    logger.info  Time.now.strftime("%Y-%m-%d %H:%M:%S").to_s + " " + job_id + ":" + "バッチ処理を起動しました。"
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 全角の末尾のＳＰＡＣＥを削除します
  # === 引数
  #  str :            入力文字列
  # === 戻り値
  #  出力文字列
  #------------------------------------------------------------------------------------------------
  def jp_rstrip(str)
    if str.blank?
      return ""
    end
    return str.sub(/[\s　]+\z/,"")
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 帰社報告情報を取得する
  # === 引数
  #  staff_no:           社員番号
  # === 戻り値
  #  戻り                社員名
  #------------------------------------------------------------------------------------------------
  def get_month_report_status(staff_no, today)
    if staff_no.blank?
      return ''
    end
    month_report = MonthReport.where('staff_no=? and report_date_ym=?', staff_no, today)[0]
    if month_report.blank?
      return ''
    else
      return month_report.status
    end
  end

  module_function :get_business_date
  module_function :not_business_day?
  module_function :holiday?
  module_function :get_receipt_no
  module_function :get_order_no
  module_function :get_deliver_no
  module_function :get_staff_name
  module_function :get_dept
  module_function :get_money
  module_function :get_disp_number
  module_function :get_disp_percent
  module_function :get_disp_date
  module_function :get_disp_time
  module_function :get_client_name
  module_function :get_client_rname
  module_function :get_client_sub_name
  module_function :get_customer_name
  module_function :get_customer_rname
  module_function :get_customer_sub_name
  module_function :get_provider_name
  module_function :get_provider_rname
  module_function :get_provider_sub_name

  module_function :get_company_name
  module_function :get_item_name
  module_function :get_bank_name
  module_function :get_bank_kananame
  module_function :get_bank_prname
  module_function :get_branch_name
  module_function :get_message
  module_function :convert_csv_data
  module_function :get_name
  module_function :get_wdate_name
  module_function :set_fixed_rec_str
  module_function :set_fixed_rec_num
  module_function :edit_fixed_str
  module_function :set_batch_req_message
  module_function :get_month_report_status

end
