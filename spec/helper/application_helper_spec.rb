require 'rails_helper'

describe ApplicationHelper, :type => :helper  do
  #----------------------------------------------------------------------------
  #    終了ボタンを押された場合の戻りURL取得メソッド
  #----------------------------------------------------------------------------
  describe '終了ボタンを押された場合の戻りURL取得メソッド' do
    it 'メソッドが存在すること' do
      #helper.should be_respond_to("back_menu_url")
      #expect(helper).to be_respond_to(:back_menu_url)
      expect(helper.respond_to?(:back_menu_url)).to be true
    end 

    context "正常に動作しているか" do
      it '/menu/menu0010が返ってくること' do
        expect(helper.back_menu_url()).to eq "/menu/menu0010"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    年数計算メソッド
  #----------------------------------------------------------------------------
  describe '年数計算メソッド' do
    it 'メソッドが存在すること' do
      expect(helper.respond_to?(:get_nen)).to be true
    end 

    context "正常に動作しているか" do
      before do
        @calc_date = Date.today.years_ago(1)
      end
      it '年数が計算されて返ってくること(1年)' do
        expect(helper.get_nen(@calc_date)).to eq 1
      end
      it '年数が計算されて返ってくること(1年未満)' do
        @calc_date += 1
        expect(helper.get_nen(@calc_date)).to eq 0
      end
    end
  end
  #----------------------------------------------------------------------------
  #    永年勤続報奨金取得メソッド
  #----------------------------------------------------------------------------
  describe '永年勤続報奨金取得メソッド' do
    it 'メソッドが存在すること' do
      expect(helper.respond_to?(:get_gift_kinzoku)).to be true
    end 

    context "正常に動作しているか" do
      before do
        GiftMaster.create(
          gift_div:       1,
          year_flg:       1,
          condition_year: 25,
          condition:      "AAA",
          amount:         "BBB"
         )
      end
      it '祝い金情報が返ってくること' do
        expect(helper.get_gift_kinzoku(25)).to eq 'AAA　BBB'
        p '-------------------------------------'
        p helper.get_gift_kinzoku(25)
        p '-------------------------------------'
      end
      it '祝い金情報が返ってこないこと' do
        expect(helper.get_gift_kinzoku(20)).to eq ''
        p '-------------------------------------'
        p helper.get_gift_kinzoku(20)
        p '-------------------------------------'
      end
    end
  end
end
