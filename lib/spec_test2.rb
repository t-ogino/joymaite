# -*- encoding: utf-8 -*-
module SpecTest2
  module_function
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 数値の配列をソートします
  # === 引数
  #  arr:     ソート前配列
  # === 戻り値
  #  ソート済配列
  #------------------------------------------------------------------------------------------------
  def get_sort(para, arr)
    # 入力必須チェック
    if arr.blank?
      return ''
    end 
    # 入力必須チェック
    if para == :asc or para == :desc
    else
      return ''
    end 
    # 入力型チェック
    unless arr.kind_of?(Array)
      return ''
    end 
    # 変換処理
    if para == :asc
      return arr.sort
    else
      return arr.sort{|a,b| b<=>a}
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 入力された配列が数値の場合、合計値を返却します        [1.2.3.4.5] => 15
  # 入力された配列が文字の場合、文字を結合して返却します  ["1"."2"."3"."4"."5"] => "12345"
  # === 引数
  #  arr:     変換前日付
  #  patern:   変換形式
  # === 戻り値
  #  編集後日付
  #------------------------------------------------------------------------------------------------
  def get_union(arr)
    # 入力必須チェック
    if arr.blank?
      return ''
    end
    # 入力型チェック
    unless arr.kind_of?(Array)
      return ''
    end 
    # 入力文字チェック（数字か文字列か）
    bol_suji = true
    for i in 0..arr.size - 1 do
      #unless arr[i].is_a?(Numeric)
      unless arr[i].kind_of?(Numeric)
        bol_suji = false
      end
    end
    # 連結処理
    if bol_suji == true
      # 数字の場合
      sum = 0
      for i in 0..arr.size - 1 do
        sum += arr[i]
      end
      return sum
    else
      # 文字列の場合
      sum_str = ''
      for i in 0..arr.size - 1 do
        sum_str += arr[i]
      end
      return sum_str
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # ひらがな文字をカタカナ文字に変換します
  # ひらがな文字以外が入力されていた場合には、「不正な文字列です」を返却します
  # === 引数
  #  str:     変換前文字列
  # === 戻り値
  #  変換後文字列
  #------------------------------------------------------------------------------------------------
  def get_kana(str)

    # 入力必須チェック
    if str.blank?
      return ''
    end
    # 入力型チェック
    unless str.kind_of?(String)
      return ''
    end 
    # 変換文字列定義
    hira = 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよわをん'
    kana = 'アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨワヲン'
    # 変換処理
    err_flg = false
    rtn_str = ''
    for i in 0..str.size - 1 do
       index = hira.index(str[i])
       if index == nil
         err_flg = true
         break
       else
         rtn_str += kana[index]
       end
    end
    if err_flg == true
      return "不正な文字列です"
    else
      return rtn_str
    end
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 数値の配列をソートします
  # === 引数
  #  arr:     ソート前配列
  # === 戻り値
  #  ソート済配列
  #------------------------------------------------------------------------------------------------
  def get_sortx(para, arr)
    # 入力必須チェック
    if arr.blank?
      raise Exception.new('入力されていません')
    end 
    # 入力必須チェック
    if para == :asc or para == :desc
    else
      return ''
    end 
    # 入力型チェック
    unless arr.kind_of?(Array)
      return ''
    end 
    # 変換処理
    if para == :asc
      return arr.sort
    else
      return arr.sort{|a,b| b<=>a}
    end
  end
end
