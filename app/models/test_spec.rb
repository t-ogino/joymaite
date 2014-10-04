# -*- encoding: utf-8 -*-
class TestSpec
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 入力された日付をYYYY/MM/DDに編集します
  # === 引数
  #  date:     変換前日付
  # === 戻り値
  #  編集後日付(yyyy/mm/dd)
  #------------------------------------------------------------------------------------------------
  def get_edit_date(date)
    # 入力必須チェック
    if date.blank?
      return ''
    end 
    # 入力型チェック
    unless date.kind_of?(Date)
      return ''
    end 
    return date.strftime("%Y/%m/%d")
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 入力された日付を指定された形式に編集します
  # === 引数
  #  date:     変換前日付
  #  patern:   変換形式
  # === 戻り値
  #  編集後日付
  #------------------------------------------------------------------------------------------------
  def get_edit_date2(date, patern)
    # 入力必須チェック
    if date.blank?
      return ''
    end
    # 入力型チェック
    unless date.kind_of?(Date)
      return ''
    end 
    if patern != "%Y/%m/%d" && patern != "%Y-%m-%d"
      return ''
    end
    return date.strftime(patern)
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
      return '明治' + sprintf("%02d", date.strftime("%Y").to_i - 1867) + '年' + date.strftime("%m月%d日")
    elsif taisyo_start <= date && date < syowa_start
      return '大正' + sprintf("%02d", date.strftime("%Y").to_i - 1911) + '年' + date.strftime("%m月%d日")
    elsif syowa_start <= date && date < heisei_start
      return '昭和' + sprintf("%02d", date.strftime("%Y").to_i - 1925) + '年' + date.strftime("%m月%d日")
    elsif heisei_start <= date
      return '平成' + sprintf("%02d", date.strftime("%Y").to_i - 1988) + '年' + date.strftime("%m月%d日")
    end
  end
end
