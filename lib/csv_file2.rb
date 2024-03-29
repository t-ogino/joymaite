﻿# -*- encoding: utf-8 -*-
#----------------------------------------------------------------------------
# === クラス概要
# CSVレコード
# === アクセサメソッド
#----------------------------------------------------------------------------
class CsvFile2
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  # 入力レコード項目
  attr_accessor :name, :sex, :birth, :email

  CSV_COL_NAME  = 0
  CSV_COL_SEX   = 1
  CSV_COL_BIRTH = 2
  CSV_COL_EMAIL = 3

  #---------------------------------------------------------------------------
  # === メソッド概要
  #  コンストラクタ
  # === 戻り値
  #---------------------------------------------------------------------------
  def initialize(rec)
    rec.chomp!
    rec     = utf8_encode(rec).split(',')
    @name   = rec[CSV_COL_NAME].delete('"')
    @sex    = rec[CSV_COL_SEX].delete('"')
    @birth  = rec[CSV_COL_BIRTH].delete('"')
    @email  = rec[CSV_COL_EMAIL].delete('"')
    # 入力チェック
    validate_name(@name)
    validate_sex(@sex)
    validate_birth(@birth)
    validate_email(@email)
  end

  #----------------------------------------------------------------------------
  # === メソッド概要
  #  S-JIS → UTF-8 変換処理
  # === 引数
  #  str:  S-JIS文字列
  # === 戻り値
  #  str:  UTF-8文字列
  #----------------------------------------------------------------------------
  def utf8_encode(str)
    str.encode("utf-8", "windows-31j")
  end

  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 名前が全角文字のみであることをチェックします
  # === 引数
  #  name:  年月日（文字列）
  # === 戻り値
  #  エラーメッセージ
  #------------------------------------------------------------------------------------------------
  def validate_name(name)
    unless name =~ /^[^ -~｡-ﾟ]*$/
      errors.add(:name, "名前は全角文字を入力してください")
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 性別が１または２であることをチェックします
  # === 引数
  #  sex:  性別
  # === 戻り値
  #  エラーメッセージ
  #------------------------------------------------------------------------------------------------
  def validate_sex(sex)
    if sex == "1" or sex == "2"
    else
      errors.add(:sex, "性別は男(1)または女(2)を入力してください")
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 生年月日が実在日であることをチェックします
  # === 引数
  #  sex:  性別
  # === 戻り値
  #  エラーメッセージ
  #------------------------------------------------------------------------------------------------
  def validate_birth(birth)
    if SpecTest52.get_edit_birth(birth).blank?
      errors.add(:birth, "生年月日が存在しない日付です")
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # メールアドレスの形式チェックを行います
  # === 引数
  #  sex:  性別
  # === 戻り値
  #  エラーメッセージ
  #------------------------------------------------------------------------------------------------
  def validate_email(email)
    unless email =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
      errors.add(:email, "メールアドレスの形式が誤っています。")
    end
  end
  
  #---------------------------------------------------------------------------
  # === メソッド概要
  #  ActiveModelで必要なメソッド
  # === 戻り値
  #---------------------------------------------------------------------------
  def persisted?   
    false  
  end
end
