require 'rails_helper'

describe CmnUtils do
  #----------------------------------------------------------------------------
  #    営業日取得モジュール
  #----------------------------------------------------------------------------
=begin
  describe '営業日取得モジュール'
    it 'メソッドが存在すること' do
      expect(CmnUtils.respond_to?(:get_business_date)).to be true
    end
    context '引数が平日の場合' do
      it 'そのままの日付が返却されること' do
        test_date   = Date.new(2017, 7, 17)
        return_date = CmnUtils.get_business_date(test_date)
        expect(return_date).to eq test_date
      end
  end
=end
  #----------------------------------------------------------------------------
  #    名称取得モジュール
  #----------------------------------------------------------------------------
  describe '名称取得モジュール'
    it 'メソッドが存在すること' do
      expect(CmnUtils.respond_to?(:get_name)).to be true
    end
    context '引数が平日の場合' do
      before do
        NameMst.create(
           code_id: "1",
           code:    "123",
           name:    "設定名称"
        )
      end
      it '名称が返却されること' do
        return_name = CmnUtils.get_name("1","123")
        expect(return_name).to eq "設定名称"
      end
  end



end
