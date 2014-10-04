require 'rails_helper'

describe SpecTest do
  #----------------------------------------------------------------------------
  #    日付編集モジュール１
  #----------------------------------------------------------------------------
  describe '日付取得モジュール１' do
    it 'メソッドが存在すること' do
      expect(SpecTest.respond_to?(:get_edit_date)).to be true
    end
    context '引数が未入力' do
      it '空文字が返却されること' do
        test_date   = nil
        return_date = SpecTest.get_edit_date(test_date)
        expect(return_date).to eq ''
      end
    end
    context '引数が日付以外' do
      it '空文字が返却されること' do
        test_date   = '1234567'
        return_date = SpecTest.get_edit_date(test_date)
        expect(return_date).to eq ''
      end
    end
    context '引数を入力' do
      it '編集文字が返却されること' do
        test_date   = Date.new(2017, 7, 17)
        return_date = SpecTest.get_edit_date(test_date)
        expect(return_date).to eq '2017/07/17'
      end
    end
  end
  #----------------------------------------------------------------------------
  #    日付編集モジュール２
  #----------------------------------------------------------------------------
  describe '日付取得モジュール２' do
    it 'メソッドが存在すること' do
      expect(SpecTest.respond_to?(:get_edit_date2, "%Y/%m/%d")).to be true
    end
    context '引数が未入力' do
      it '空文字が返却されること' do
        test_date   = nil
        return_date = SpecTest.get_edit_date2(test_date, "%Y/%m/%d")
        expect(return_date).to eq ''
      end
    end
    context '引数が日付以外' do
      it '空文字が返却されること' do
        test_date   = '1234567'
        return_date = SpecTest.get_edit_date2(test_date, "%Y/%m/%d")
        expect(return_date).to eq ''
      end
    end
    context '引数を入力(%Y/%m/%d)' do
      it '編集文字が返却されること' do
        test_date   = Date.new(2017, 7, 17)
        return_date = SpecTest.get_edit_date2(test_date, "%Y/%m/%d")
        expect(return_date).to eq '2017/07/17'
      end
    end
    context '引数を入力(%Y-%m-%d)' do
      it '編集文字が返却されること' do
        test_date   = Date.new(2017, 7, 17)
        return_date = SpecTest.get_edit_date2(test_date, "%Y-%m-%d")
        expect(return_date).to eq '2017-07-17'
      end
    end
  end
  #----------------------------------------------------------------------------
  #    和暦変換モジュール
  #----------------------------------------------------------------------------
  describe '和暦変換モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest.respond_to?(:get_wareki_date)).to be true
    end
    context '引数が未入力' do
      it '空文字が返却されること' do
        test_date   = nil
        return_date = SpecTest.get_wareki_date(test_date)
        expect(return_date).to eq ''
      end
    end
    context '引数が日付以外' do
      it '空文字が返却されること' do
        test_date   = '1234567'
        return_date = SpecTest.get_wareki_date(test_date)
        expect(return_date).to eq ''
      end
    end
    context '引数を入力（明治以前）' do
      it '編集文字が返却されること' do
        test_date   = Date.new(1868, 9, 7)
        return_date = SpecTest.get_wareki_date(test_date)
        expect(return_date).to eq ''
      end
    end
    context '引数を入力（明治）' do
      it '編集文字が返却されること' do
        test_date   = Date.new(1868, 9, 8)
        return_date = SpecTest.get_wareki_date(test_date)
        expect(return_date).to eq '明治01年09月08日'
      end
    end
    context '引数を入力（大正）' do
      it '編集文字が返却されること' do
        test_date   = Date.new(1912, 7, 30)
        return_date = SpecTest.get_wareki_date(test_date)
        expect(return_date).to eq '大正01年07月30日'
      end
    end
    context '引数を入力（昭和）' do
      it '編集文字が返却されること' do
        test_date   = Date.new(1926, 12, 25)
        return_date = SpecTest.get_wareki_date(test_date)
        expect(return_date).to eq '昭和01年12月25日'
      end
    end
    context '引数を入力（平成）' do
      it '編集文字が返却されること' do
        test_date   = Date.new(1989, 1, 8)
        return_date = SpecTest.get_wareki_date(test_date)
        expect(return_date).to eq '平成01年01月08日'
      end
    end
  end
end
