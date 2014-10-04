require 'rails_helper'

describe SpecTest31 do
  #----------------------------------------------------------------------------
  #    ＣＳＶ編集処理モジュール
  #----------------------------------------------------------------------------
  describe 'ＣＳＶ編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest31).to be_respond_to(:make_edit_csv)
    end
    context '戻り値がtureであること' do
      it '正常終了すること' do
        rtn_str = SpecTest31.make_edit_csv()
        expect(rtn_str).to eq [["島根一郎","男","1950年01月01日生まれ"],["shimanenekko","不明","不明"],["島根二子","女","1960年02月02日生まれ"]]
      end
    end
  end
  #----------------------------------------------------------------------------
  #    名前編集処理モジュール
  #----------------------------------------------------------------------------
  describe '名前編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest31).to be_respond_to(:get_edit_name)
    end
    context '全角ＳＰＡＣＥが含まれている場合' do
      it '全角ＳＰＡＣＥが取り除かれていること' do
        rtn_str = SpecTest31.get_edit_name("島根　太郎")
        expect(rtn_str).to eq "島根太郎"
      end
    end
    context '全角ＳＰＡＣＥが含まれていない場合' do
      it '入力された値がそのまま返ってくること' do
        rtn_str = SpecTest31.get_edit_name("島根花子")
        expect(rtn_str).to eq "島根花子"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    性別編集処理モジュール
  #----------------------------------------------------------------------------
  describe '性別編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest31).to be_respond_to(:get_sex_name)
    end
    context '入力コードが１（数字）の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest31.get_sex_name(1)
        expect(rtn_str).to eq "男"
      end
    end
    context '入力コードが"１"（文字列）の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest31.get_sex_name("1")
        expect(rtn_str).to eq "男"
      end
    end
    context '入力コードが２（数字）の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest31.get_sex_name(2)
        expect(rtn_str).to eq "女"
      end
    end
    context '入力コードが"２"（文字列）の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest31.get_sex_name("2")
        expect(rtn_str).to eq "女"
      end
    end
    context '上記以外の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest31.get_sex_name(9)
        expect(rtn_str).to eq "不明"
      end
    end
    context '未入力の場合' do
      it '「男」が返ってること' do
        rtn_str = SpecTest31.get_sex_name("")
        expect(rtn_str).to eq "不明"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    生年月日編集処理モジュール
  #----------------------------------------------------------------------------
  describe '生年月日編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest31).to be_respond_to(:get_edit_birth)
    end
    context '入力日付が８文字未満場合' do
      it '「不明」が返ってくること' do
        rtn_str = SpecTest31.get_edit_birth("2014728")
        expect(rtn_str).to eq "不明"
      end
    end
    context '存在しない日付の場合' do
      it '「不明」が返ってくること' do
        rtn_str = SpecTest31.get_edit_birth("20140229")
        expect(rtn_str).to eq "不明"
      end
    end
    context '存在する日付の場合' do
      it '編集された日付が返ってくること' do
        rtn_str = SpecTest31.get_edit_birth("19500101")
        expect(rtn_str).to eq "1950年01月01日生まれ"
      end
    end
  end
end
