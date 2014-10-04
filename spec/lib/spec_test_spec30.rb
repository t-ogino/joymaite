require 'rails_helper'

describe SpecTest30 do
  #----------------------------------------------------------------------------
  #    ＣＳＶ編集処理モジュール
  #----------------------------------------------------------------------------
  describe 'ＣＳＶ編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest30).to be_respond_to(:make_edit_csv)
    end
    context '戻り値がtureであること' do
      it '正常終了すること' do
        rtn_cd = SpecTest30.make_edit_csv()
        expect(rtn_cd).to eq true
      end
    end
  end
  #----------------------------------------------------------------------------
  #    名前編集処理モジュール
  #----------------------------------------------------------------------------
  describe '名前編集処理モジュール' do
    it 'メソッドが存在すること' do
      expect(SpecTest30).to be_respond_to(:get_edit_name)
    end
    context '戻り値がtureであること' do
      it '正常終了すること' do
        rtn_cd = SpecTest30.get_edit_name("島根　太郎")
        expect(rtn_cd).to eq "島根太郎"
      end
    end
  end
end
