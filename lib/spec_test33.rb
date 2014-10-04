# -*- encoding: utf-8 -*-
module SpecTest33
  module_function
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 読み込んだＣＳＶを編集して出力します。
  # === 引数
  #  なし
  # === 戻り値
  #  編集済ＣＳＶ
  #------------------------------------------------------------------------------------------------
  def make_edit_csv(in_file_path)
    begin
      # 出力配列
      arr = Array.new
  
      # CSV読み込み
      # in_file_path = "spec/lib/test.csv"
      File::open(in_file_path, "rb") do |f|
        f.each do |rec|
            csv_rec = CsvFile.new(rec)      # CSVレコード定義
            # 出力レコード初期化
            rec_hash = Hash.new
            err_arr  = Array.new
            # 名前チェック
            if check_zenkaku(csv_rec.name) == false
              err_arr << "名前は全角文字を入力してください"
            end
            if get_age(csv_rec.birth) == "不明"
              err_arr << "生年月日は存在する日付を入力してください"
            end
            if err_arr.blank?
              # 編集処理（氏名）
              rec_hash.store("last_name",get_last_name(csv_rec.name))
              rec_hash.store("first_name",get_first_name(csv_rec.name))
              # 編集処理（性別）
              rec_hash.store("sex",get_sex_name(csv_rec.sex))
              # 編集処理（年齢）
              rec_hash.store("age",get_age(csv_rec.birth))
            else
              rec_hash.store("errors",err_arr.join(","))
            end
            # 出力
            arr << rec_hash
        end
      end
  
      return arr

    # エラー処理
    rescue => e
       p e.message
       raise Exception.new("FileNotFoundError")
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 名前から全角ＳＰＡＣＥを削除しを返却します
  # === 引数
  #  name:  名前
  # === 戻り値
  #  編集後名前
  #------------------------------------------------------------------------------------------------
  def get_edit_name(name)
    name.gsub(/(\s|　)+/, '')
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 全角ＳＰＡＣＥを区切り文字とし名前から姓だけを返却します
  # === 引数
  #  name:  名前
  # === 戻り値
  #  姓
  #------------------------------------------------------------------------------------------------
  def get_first_name(name)
    if name.blank?
      return ""
    end
    w_name = name.split("　")
    return w_name[1]
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 全角ＳＰＡＣＥを区切り文字とし名前から名だけを返却します
  # === 引数
  #  name:  名前
  # === 戻り値
  #  名
  #------------------------------------------------------------------------------------------------
  def get_last_name(name)
    if name.blank?
      return ""
    end
    w_name = name.split("　")
    return w_name[0]
  end
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
      return "不明"
    end
    begin
      date = Date.new(birth[0,4].to_i, birth[4,2].to_i, birth[6,2].to_i )
    rescue
      return "不明"
    end
    return date.strftime("%Y年%m月%d日生まれ")
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 生年月日から年齢を算出して返却します
  # === 引数
  #  birth:  生年月日
  # === 戻り値
  #  年齢
  #------------------------------------------------------------------------------------------------
  def get_age(birth)
    if birth.size != 8
      return "不明"
    end
    begin
      date = Date.new(birth[0,4].to_i, birth[4,2].to_i, birth[6,2].to_i )
    rescue
      return "不明"
    end
    return ((Date.today.strftime("%Y%m%d").to_i - date.strftime("%Y%m%d").to_i) / 10000).to_s + "歳"
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 全角文字だけでできていることをチェックします
  # === 引数
  #  str:  文字列
  # === 戻り値
  #  true:正常（全角だけでできている）　false:エラー（全角以外の文字が混入している）
  #------------------------------------------------------------------------------------------------
  def check_zenkaku(str)
    if /[ -~｡-ﾟ]/ =~ str
      return false
    else
      return true
    end
  end
end
