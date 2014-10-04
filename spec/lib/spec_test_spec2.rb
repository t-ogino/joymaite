require 'rails_helper'

describe SpecTest2 do
  #----------------------------------------------------------------------------
  #    配列ソート処理モジュール
  #----------------------------------------------------------------------------
  describe '配列ソート処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest2.respond_to?(:get_sort)).to be true
    end
    context '引数が未入力' do
      it '空文字が返却されること' do
        test_arr   = nil
        return_arr = SpecTest2.get_sort(:asc, test_arr)
        expect(return_arr).to eq ''
      end
    end
    context '引数が空配列' do
      it '空文字が返却されること' do
        test_arr   = []
        return_arr = SpecTest2.get_sort(:asc, test_arr)
        expect(return_arr).to eq ''
      end
    end
    context '引数が配列以外' do
      it '空文字が返却されること' do
        test_arr   = '1234567'
        return_arr = SpecTest2.get_sort(:asc, test_arr)
        expect(return_arr).to eq ''
      end
    end
    context '引数の順指定が未入力' do
      it '空文字が返却されること' do
        test_arr   = [5,6,3,2,1,9,4,8,7,0]
        return_arr = SpecTest2.get_sort('', test_arr)
        expect(return_arr).to eq ''
      end
    end
    context '引数を入力（昇順）' do
      it 'ソートされて返却されること' do
        test_arr   = [5,6,3,2,1,9,4,8,7,0]
        return_arr = SpecTest2.get_sort(:asc, test_arr)
        expect(return_arr).to eq [0,1,2,3,4,5,6,7,8,9]
      end
    end
    context '引数を入力（降順）' do
      it 'ソートされて返却されること' do
        test_arr   = [5,6,3,2,1,9,4,8,7,0]
        return_arr = SpecTest2.get_sort(:desc, test_arr)
        expect(return_arr).to eq [9,8,7,6,5,4,3,2,1,0]
      end
    end
  end
  #----------------------------------------------------------------------------
  #    配列内容編集モジュール
  #----------------------------------------------------------------------------
  describe '配列内容編集モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest2.respond_to?(:get_union)).to be true
    end
    context '引数が未入力' do
      it '空文字が返却されること' do
        test_arr   = nil
        return_str = SpecTest2.get_union(test_arr)
        expect(return_str).to eq ''
      end
    end
    context '引数が空配列' do
      it '空文字が返却されること' do
        test_arr   = []
        return_str = SpecTest2.get_union(test_arr)
        expect(return_str).to eq ''
      end
    end
    context '引数が配列以外' do
      it '空文字が返却されること' do
        test_arr   = '1234567'
        return_str = SpecTest2.get_union(test_arr)
        expect(return_str).to eq ''
      end
    end
    context '引数を入力（数字）' do
      it '合計値が返却されること' do
        test_arr   = [1,2,3,4,5]
        return_str = SpecTest2.get_union(test_arr)
        expect(return_str).to eq 15
      end
    end
    context '引数を入力（文字列）' do
      it '文字列が連結されて返却されること' do
        test_arr   = ["1","2","3","4","5"]
        return_str = SpecTest2.get_union(test_arr)
        expect(return_str).to eq "12345"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    ひらがなカタカナ変換モジュール
  #----------------------------------------------------------------------------
  describe 'ひらがなカタカナ変換モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest2.respond_to?(:get_kana)).to be true
    end
    context '引数が未入力' do
      it '空文字が返却されること' do
        test_str   = nil
        return_str = SpecTest2.get_kana(test_str)
        expect(return_str).to eq ''
      end
    end
    context '引数がひらがな以外' do
      it '「不正な文字列です」が返却されること' do
        test_str   = '1234567'
        return_str = SpecTest2.get_kana(test_str)
        expect(return_str).to eq '不正な文字列です'
      end
    end

    context '引数を入力' do
      it '編集文字が返却されること' do
        test_str   = 'あいうえお'
        return_str = SpecTest2.get_kana(test_str)
        expect(return_str).to eq 'アイウエオ'
      end
    end
  end
  #----------------------------------------------------------------------------
  #    配列ソート処理モジュール2
  #----------------------------------------------------------------------------
  describe '配列ソート処理モジュール2' do
    it 'メソッドが存在すること' do
      expect(SpecTest2.respond_to?(:get_sortx)).to be true
    end
    context '引数が未入力' do
      it '異常終了すること' do
        test_arr   = nil
        expect{ SpecTest2.get_sortx(:asc, test_arr) }.to raise_exception
      end
    end
    context '引数が未入力2' do
      it '異常終了すること' do
        test_arr   = nil
        #expect{ SpecTest2.get_sortx(:asc, test_arr) }.to raise_error(Exception, '入力されていません')
        expect{ SpecTest2.get_sortx(:asc, test_arr) }.to raise_exception(Exception, '入力されていません')
      end
    end
  end
end
