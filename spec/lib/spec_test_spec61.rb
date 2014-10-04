require 'rails_helper'

describe SpecTest61 do
  #----------------------------------------------------------------------------
  #    除算結果編集処理モジュール
  #----------------------------------------------------------------------------
  describe '除算結果編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest61).to be_respond_to(:division)
    end
    context 'SpecTest61.division(1, 1)' do
      it '「1」が返ってくること' do
        rtn_str = SpecTest61.division(1, 1)     # => 1
        expect(rtn_str).to eq 1
      end
    end
    context 'SpecTest61.division(1, 1)' do
      it '「0.1」が返ってくること' do
        rtn_str = SpecTest61.division(1, 10)    # => 0.1
        expect(rtn_str).to eq 0.1
      end
    end
    context 'SpecTest61.division(1, 1)' do
      it '「0.01」が返ってくること' do
        rtn_str = SpecTest61.division(1, 100)   # => 0.01
        expect(rtn_str).to eq 0.01
      end
    end
    context 'SpecTest61.division(1, 1)' do
      it '「0.001」が返ってくること' do
        rtn_str = SpecTest61.division(1, 1000)  # => 0.001
        expect(rtn_str).to eq 0.001
      end
    end
    context 'SpecTest61.division(1, 1)' do
      it '「0」が返ってくること' do
        rtn_str = SpecTest61.division(1, 10000) # => 0
        expect(rtn_str).to eq 0
      end
    end
    context 'SpecTest61.division(12345, 100)' do
      it '「123.45」が返ってくること' do
        rtn_str = SpecTest61.division(12345, 100) # => 0
        expect(rtn_str).to eq 123.45
      end
    end
    context 'SpecTest61.division(1234567890, 10000)' do
      it '「123456.789」が返ってくること' do
        rtn_str = SpecTest61.division(1234567890, 10000) # => 0
        expect(rtn_str).to eq 123456.789
      end
    end
  end
  #----------------------------------------------------------------------------
  #    オブジェクトソート処理モジュール
  #----------------------------------------------------------------------------
  describe 'オブジェクトソート編集処理モジュール' do
    context 'エラーチェック1' do
      it '入力された値がそのままが返ってくること' do
        rtn_str = SpecTest61.d_sort("asc", 12345)
        expect(rtn_str).to eq 12345
      end
    end
    context 'エラーチェック2' do
      it '入力された値がそのままが返ってくること' do
        rtn_str = SpecTest61.d_sort("asc", [12345])
        expect(rtn_str).to eq [12345]
      end
    end
    context 'エラーチェック3' do
      it '入力された値がそのままが返ってくること' do
        data = [StoreData.new(first_key:1, second_key:2, name:"B")]
        rtn_str = SpecTest61.d_sort("asc", data)
        expect(rtn_str).to eq data
      end
    end
    context 'データソート処理' do
      before do
        @data = [
          StoreData.new(first_key:1, second_key:2, name:"B"),
          StoreData.new(first_key:3, second_key:2, name:"H"),
          StoreData.new(first_key:2, second_key:1, name:"D"),
          StoreData.new(first_key:1, second_key:1, name:"A"),
          StoreData.new(first_key:2, second_key:3, name:"F"),
          StoreData.new(first_key:3, second_key:1, name:"G"),
          StoreData.new(first_key:2, second_key:2, name:"E"),
          StoreData.new(first_key:1, second_key:3, name:"C"),
          StoreData.new(first_key:3, second_key:3, name:"I")
        ]
      end
      it '昇順でデータが返ってくること' do
        rtn_array = SpecTest61.d_sort("asc", @data)
        sort_names = ""
        rtn_array.each do |rtn|
          sort_names += rtn.name
        end
        expect(sort_names).to eq 'ABCDEFGHI'
      end
      it '降順でデータが返ってくること' do
        rtn_array = SpecTest61.d_sort("desc", @data)
        sort_names = ""
        rtn_array.each do |rtn|
          sort_names += rtn.name
        end
        expect(sort_names).to eq 'IHGFEDCBA'
      end
    end
  end
  #----------------------------------------------------------------------------
  #    ＣＳＶ編集処理モジュール
  #----------------------------------------------------------------------------
  describe 'ActiveModelの確認' do
    context 'ActiveModelの確認' do
      before do
        rec = "島根一郎,英語:20,数学:100,理科:50".encode("windows-31j","utf-8")
        @csv = CsvFile3.new(rec)
      end
      it '正しい値が返ってくることすること(名前)' do
        expect(@csv.name).to eq "島根一郎"
      end
      it '正しい値が返ってくることすること(英語)' do
        expect(@csv.eigo).to eq "20"
      end
      it '正しい値が返ってくることすること(数学)' do
        expect(@csv.sugaku).to eq "100"
      end
      it '正しい値が返ってくることすること(理科)' do
        expect(@csv.rika).to eq "50"
      end
      it '正しい値が返ってくることすること(合計)' do
        expect(@csv.sum).to eq 170
      end
      it '正しい値が返ってくることすること(平均)' do
        expect(@csv.avg).to eq 56
      end
      it '正しい値が返ってくることすること(最大値)' do
        expect(@csv.max).to eq 100
      end
      it '正しい値が返ってくることすること(最小値)' do
        expect(@csv.min).to eq 20
      end
    end
  end
  describe 'ＣＳＶ編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest61).to be_respond_to(:disp_csv_seiseki)
    end
    context '指定したファイルが存在しない場合' do
      it 'エラーが発生すること' do
        expect {SpecTest61.disp_csv_seiseki("C:/src/joymaite/spec/lib/testx.csv") }.to raise_error("FileNotFoundError")
      end
    end
    context '戻り値が正しく返却されること' do
      it '正常終了すること' do
        expect_str  = "島根一郎さん：総合＝170点　平均＝56点　最高＝100点　最低＝20点" + "\r\n"
        expect_str += "島根ニ郎さん：総合＝240点　平均＝80点　最高＝90点　最低＝70点"  + "\r\n"
        expect_str += "島根三郎さん：総合＝120点　平均＝40点　最高＝60点　最低＝20点"  + "\r\n"

        rtn_str = SpecTest61.disp_csv_seiseki("C:/src/joymaite/spec/lib/test61.csv")
        expect(rtn_str).to eq expect_str
      end
    end
  end
end
