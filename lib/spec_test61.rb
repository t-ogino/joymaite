# -*- encoding: utf-8 -*-
module SpecTest61
  module_function
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 指定された二つの数値を割った結果を以下の仕様で出力します
  # ・小数点以下第３位までを表示する
  # ・小数点以下第３位までが全て０となる場合は整数を表示する
  #＜例＞
  #　SpecTest61.division(1, 1)     # => 1
  #　SpecTest61.division(1, 10)    # => 0.1
  #　SpecTest61.division(1, 100)   # => 0.01
  #　SpecTest61.division(1, 1000)  # => 0.001
  #　SpecTest61.division(1, 10000) # => 0
  #
  # === 引数
  #  num:  編集対象数字
  #  opt:  オプション
  # === 戻り値
  #  編集後文字
  #------------------------------------------------------------------------------------------------
  def division(num, opt)
    ans = num.to_f / opt.to_f
    sprintf("%10.3f", ans).to_f
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # データ保存オブジェクトに指定されないようをソートします
  #
  # === 引数
  #  para:  asc:昇順   desc:降順
  #  data:  データ
  # === 戻り値
  #  ソート済データ
  #------------------------------------------------------------------------------------------------
  def d_sort(para, data)
    # 入力型チェック
    unless data.kind_of?(Array)
      return data
    end 
    unless data[0].kind_of?(StoreData)
      return data
    end 
    case para
    when "asc"
      return data.sort_by {|a| [a.first_key, a.second_key] }
    when "desc"
      data.sort! do |a, b|
        (b.first_key <=> a.first_key).nonzero? ||
          (b.second_key <=> a.second_key)
      end
      return data
    else
      return data
    end
  end
  #------------------------------------------------------------------------------------------------
  # === メソッド概要
  # 読み込んだＣＳＶをから点数を編集して出力します。
  # === 引数
  #  ＣＳＶのファイル名（ディレクトリ付き）
  # === 戻り値
  #  なし
  #------------------------------------------------------------------------------------------------
  def disp_csv_seiseki(in_file_path)
    begin
      # 出力領域
      out = ""
      # CSV読み込み
      # in_file_path = "spec/lib/test61.csv"
      File::open(in_file_path, "rb") do |f|
        f.each do |rec|
            csv_rec = CsvFile3.new(rec)                         # CSVレコード定義
            out += csv_rec.name + "さん："                      # 名前
            out += "総合＝"     + csv_rec.sum.to_s + "点　"     # 合計
            out += "平均＝"     + csv_rec.avg.to_s + "点　"     # 平均点
            out += "最高＝"     + csv_rec.max.to_s + "点　"     # 最高点
            out += "最低＝"     + csv_rec.min.to_s + "点"       # 最低点
            out += "\r\n"
        end
      end
      return out
    # エラー処理
    rescue => e
       p e.message
       raise Exception.new("FileNotFoundError")
    end
  end
end
