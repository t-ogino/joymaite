require 'rails_helper'

describe SpecTest33 do
  #----------------------------------------------------------------------------
  #    ＣＳＶ編集処理モジュール
  #----------------------------------------------------------------------------
  describe 'ＣＳＶ編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest33).to be_respond_to(:make_edit_csv)
    end
    context '戻り値がtureであること' do
      it '正常終了すること' do
        expect {SpecTest33.make_edit_csv("C:/src/joymaite/spec/lib/testx.csv") }.to raise_error("FileNotFoundError")
      end
    end
    context '戻り値がtureであること' do
      it '正常終了すること' do
        rtn_str = SpecTest33.make_edit_csv("C:/src/joymaite/spec/lib/test.csv")
        expect(rtn_str).to eq [{"last_name"=>"島根","first_name"=>"一郎","sex"=>"男","age"=>"64歳"},{"errors"=>"名前は全角文字を入力してください,生年月日は存在する日付を入力してください"},{"last_name"=>"島根","first_name"=>"二子","sex"=>"女","age"=>"54歳"}]
      end
    end
  end
  #----------------------------------------------------------------------------
  #    名前編集処理モジュール
  #----------------------------------------------------------------------------
  describe '名前編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest33).to be_respond_to(:get_edit_name)
    end
    context '全角ＳＰＡＣＥが含まれている場合' do
      it '全角ＳＰＡＣＥが取り除かれていること' do
        rtn_str = SpecTest33.get_edit_name("島根　太郎")
        expect(rtn_str).to eq "島根太郎"
      end
    end
    context '全角ＳＰＡＣＥが含まれていない場合' do
      it '入力された値がそのまま返ってくること' do
        rtn_str = SpecTest33.get_edit_name("島根花子")
        expect(rtn_str).to eq "島根花子"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    性別編集処理モジュール
  #----------------------------------------------------------------------------
  describe '性別編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest33).to be_respond_to(:get_sex_name)
    end
    context '入力コードが１（数字）の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest33.get_sex_name(1)
        expect(rtn_str).to eq "男"
      end
    end
    context '入力コードが"１"（文字列）の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest33.get_sex_name("1")
        expect(rtn_str).to eq "男"
      end
    end
    context '入力コードが２（数字）の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest33.get_sex_name(2)
        expect(rtn_str).to eq "女"
      end
    end
    context '入力コードが"２"（文字列）の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest33.get_sex_name("2")
        expect(rtn_str).to eq "女"
      end
    end
    context '上記以外の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest33.get_sex_name(9)
        expect(rtn_str).to eq "不明"
      end
    end
    context '未入力の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest33.get_sex_name("")
        expect(rtn_str).to eq "不明"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    生年月日編集処理モジュール
  #----------------------------------------------------------------------------
  describe '生年月日編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest33).to be_respond_to(:get_edit_birth)
    end
    context '入力日付が８文字未満場合' do
      it '「不明」が返ってくること' do
        rtn_str = SpecTest33.get_edit_birth("2014728")
        expect(rtn_str).to eq "不明"
      end
    end
    context '存在しない日付の場合' do
      it '「不明」が返ってくること' do
        rtn_str = SpecTest33.get_edit_birth("20140229")
        expect(rtn_str).to eq "不明"
      end
    end
    context '存在する日付の場合' do
      it '編集された日付が返ってくること' do
        rtn_str = SpecTest33.get_edit_birth("19500101")
        expect(rtn_str).to eq "1950年01月01日生まれ"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    名取得処理モジュール
  #----------------------------------------------------------------------------
  describe '名取得処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest33).to be_respond_to(:get_first_name)
    end
    context '未入力の場合' do
      it '空文字が返ってくること' do
        rtn_str = SpecTest33.get_first_name("")
        expect(rtn_str).to eq ""
      end
    end
    context '入力ありの場合' do
      it '姓が返ってくること' do
        rtn_str = SpecTest33.get_first_name("島根　太郎")
        expect(rtn_str).to eq "太郎"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    姓取得処理モジュール
  #----------------------------------------------------------------------------
  describe '姓取得処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest33).to be_respond_to(:get_last_name)
    end
    context '未入力の場合' do
      it '空文字が返ってくること' do
        rtn_str = SpecTest33.get_last_name("")
        expect(rtn_str).to eq ""
      end
    end
    context '入力ありの場合' do
      it '名が返ってくること' do
        rtn_str = SpecTest33.get_last_name("島根　太郎")
        expect(rtn_str).to eq "島根"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    年齢取得処理モジュール
  #----------------------------------------------------------------------------
  describe '年齢取得処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest33).to be_respond_to(:get_age)
    end
    context '未入力の場合' do
      it 'ゼロが返ってくること' do
        rtn_str = SpecTest33.get_age("")
        expect(rtn_str).to eq "不明"
      end
    end
    context '存在する日付の場合' do
      it '年齢が計算されてが返ってくること' do
        rtn_str = SpecTest33.get_age("19590514")
        expect(rtn_str).to eq "55歳"
      end
    end
  end
end
