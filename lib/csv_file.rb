# -*- encoding: utf-8 -*-
#----------------------------------------------------------------------------
# === クラス概要
# CSVレコード
# === アクセサメソッド
#----------------------------------------------------------------------------
class CsvFile
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  # 入力レコード項目
  attr_accessor :name, :sex, :birth

  CSV_COL_NAME  = 0
  CSV_COL_SEX   = 1
  CSV_COL_BIRTH = 2

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
  
  #---------------------------------------------------------------------------
  # === メソッド概要
  #  ActiveModelで必要なメソッド
  # === 戻り値
  #---------------------------------------------------------------------------
  def persisted?   
    false  
  end
  
end
