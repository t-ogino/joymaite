# -*- encoding: utf-8 -*-
module SpecTest52
  module_function
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 性別コードに対応する名称を返却します
  # === 引数
  #  sex:  性別コード(1:男 2:女)
  # === 戻り値
  #  性別名称
  #------------------------------------------------------------------------------------------------
  def get_sex_name(sex)
    case sex
    when 1 ,"1"
      "男"
    when 2 , "2"
      "女"
    else
      "不明"
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 生年月日をXXXX年XX月XX日生まれに編集して返却します
  # ただし、該当日付が存在しない場合には、不明で返却します
  # === 引数
  #  birth:  生年月日
  # === 戻り値
  #  編集後生年月日
  #------------------------------------------------------------------------------------------------
  def get_edit_birth(birth)
    if birth.size != 8
      return ""
    end
    begin
      date = Date.new(birth[0,4].to_i, birth[4,2].to_i, birth[6,2].to_i )
    rescue
      return ""
    end
    return get_wareki_date(date)
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 入力された日付を和暦日付に変換します
  # === 引数
  #  date:     変換前日付
  # === 戻り値
  #  編集後日付
  #------------------------------------------------------------------------------------------------
  def get_wareki_date(date)
    # 元号切り替わり日付
    meiji_start  = Date.new(1868, 9 ,8)
    taisyo_start = Date.new(1912, 7, 30)
    syowa_start  = Date.new(1926, 12, 25)
    heisei_start = Date.new(1989, 1, 8)
    # 入力必須チェック
    if date.blank?
      return ''
    end
    # 入力型チェック
    unless date.kind_of?(Date)
      return ''
    end 
    if date < meiji_start
      return ''
    elsif meiji_start <= date && date < taisyo_start
      return '明治' + get_wareki_edit(date, 1867)
    elsif taisyo_start <= date && date < syowa_start
      return '大正' + get_wareki_edit(date, 1911)
    elsif syowa_start <= date && date < heisei_start
      return '昭和' + get_wareki_edit(date, 1925)
    elsif heisei_start <= date
      return '平成' + get_wareki_edit(date, 1988)
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 入力された日付を和暦日付に変換します
  # === 引数
  #  date:     変換前日付
  # === 戻り値
  #  編集後日付
  #------------------------------------------------------------------------------------------------
  def get_wareki_edit(date, kijyun_yy)
    sprintf("%02d", date.strftime("%Y").to_i - kijyun_yy) + '年' + date.strftime("%m月%d日")
  end
end
