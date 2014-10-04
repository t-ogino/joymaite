# -*- encoding: utf-8 -*-
#----------------------------------------------------------------------------
# === クラス概要
# CSVレコード
# === アクセサメソッド
#----------------------------------------------------------------------------
class CsvFile3
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  # 入力レコード項目
  attr_accessor :name, :eigo, :sugaku, :rika, :sum , :min, :max, :avg

  CSV_COL_NAME   = 0
  CSV_COL_EIGO   = 1
  CSV_COL_SUGAKU = 2
  CSV_COL_RIKA   = 3

  #---------------------------------------------------------------------------
  # === メソッド概要
  #  コンストラクタ
  # === 戻り値
  #---------------------------------------------------------------------------
  def initialize(rec)
    rec.chomp!
    rec      = utf8_encode(rec).split(',')
    @name    = rec[CSV_COL_NAME].delete('"')
    @eigo    = rec[CSV_COL_EIGO].delete('"').split(":")[1]
    @sugaku  = rec[CSV_COL_SUGAKU].delete('"').split(":")[1]
    @rika    = rec[CSV_COL_RIKA].delete('"').split(":")[1]
    #合計
    @sum = @eigo.to_i + @sugaku.to_i + @rika.to_i
    @avg = @sum / 3
    @max = [@eigo.to_i , @sugaku.to_i , @rika.to_i].max
    @min = [@eigo.to_i , @sugaku.to_i , @rika.to_i].min
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
end
