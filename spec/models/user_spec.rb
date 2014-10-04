# -*- encoding: utf-8 -*-
require 'rails_helper'
RSpec.describe User, :type => :model do
  #----------------------------------------------------------------------------
  #    ＣＳＶアップロード処理
  #----------------------------------------------------------------------------
  describe 'ＣＳＶアップロード処理' do
    it 'メソッドが存在すること' do
      expect(User).to be_respond_to(:import)
    end
    context '該当しないファイルを指定' do
      it '異常終了すること' do
        expect { User.import('aaa') }.to raise_error
      end
    end
    context '該当するファイルを指定' do
      it '正常終了すること' do
        expect { User.import('C:\src\joymaite\spec\models\test.csv') }.not_to raise_error
      end
    end
    context '該当するファイルを指定' do
      before do
        User.import('C:\src\joymaite\spec\models\test.csv')
        @users = User.all
        @user1= User.new(
               name:  "島根一郎",
               sex:   "1",
               birth: "1950/01/01",
               email: "sample.i-shimane@exsample.co.jp"
        )
        @user2= User.new(
               name:  "島根二子",
               sex:   "2",
               birth: "1960/02/02",
               email: "n-shimane@exsample.co.jp"
        )
        @user3= User.new(
               name:  "島根三郎",
               sex:   "1",
               birth: "1970/03/03",
               email: "sample.s-shimane@exsample.co.jp"
        )
        @user4= User.new(
               name:  "島根四郎",
               sex:   "2",
               birth: "1980/04/04",
               email: "y-shimane@exsample.co.jp"
        )
      end
      it '４件登録されていること' do
        expect(@users.size).to eq 4
      end
      it '登録されていること1(name)' do
        #expect(@users).to match_array([@user1,@user2,@user3,@user4])
        expect(@users[0].name).to eq @user1.name
      end
      it '登録されていること1(sex)' do
        expect(@users[0].sex).to eq @user1.sex
      end
      it '登録されていること1(birth)' do
        expect(@users[0].birth).to eq @user1.birth
      end
      it '登録されていること1(email)' do
        expect(@users[0].email).to eq @user1.email
      end

      it '登録されていること2(name)' do
        expect(@users[1].name).to eq @user2.name
      end
      it '登録されていること2(sex)' do
        expect(@users[1].sex).to eq @user2.sex
      end
      it '登録されていること2(birth)' do
        expect(@users[1].birth).to eq @user2.birth
      end
      it '登録されていること2(email)' do
        expect(@users[1].email).to eq @user2.email
      end

      it '登録されていること3(name)' do
        expect(@users[2].name).to eq @user3.name
      end
      it '登録されていること3(sex)' do
        expect(@users[2].sex).to eq @user3.sex
      end
      it '登録されていること3(birth)' do
        expect(@users[2].birth).to eq @user3.birth
      end
      it '登録されていること3(email)' do
        expect(@users[2].email).to eq @user3.email
      end

      it '登録されていること4(name)' do
        expect(@users[3].name).to eq @user4.name
      end
      it '登録されていること4(sex)' do
        expect(@users[3].sex).to eq @user4.sex
      end
      it '登録されていること4(birth)' do
        expect(@users[3].birth).to eq @user4.birth
      end
      it '登録されていること4(email)' do
        expect(@users[3].email).to eq @user4.email
      end
    end
  end
  #----------------------------------------------------------------------------
  #    ＣＳＶ作成処理
  #----------------------------------------------------------------------------
  describe 'ＣＳＶ作成処理' do
    it 'メソッドが存在すること' do
      expect(User).to be_respond_to(:csv_put)
    end
    context '正常パターン' do
      it 'ＣＳＶが作成されること' do
        User.import('C:\src\joymaite\spec\models\test.csv')
        expect { User.csv_put('C:\src\joymaite\spec\models\out.csv') }.not_to raise_error
      end
    end
  end
=begin
  #----------------------------------------------------------------------------
  #    ＶＡＬＩＤＡＴＥ処理
  #----------------------------------------------------------------------------
  describe 'ＶＡＬＩＤＡＴＥ作成処理' do
    context '正常パターン' do
      before do
        @user = User.new(name: '島根', sex: '1')
      end
      it 'すべて全角文字であること' do
        expect(@user).to be_valid
      end
    end
    context '名前チェック' do
      before do
        @user = User.new(name: '島根TARO', sex: '1')
      end
      it 'すべて全角文字であること' do
        expect(@user).to_not be_valid
      end
    end
    context '性別チェック' do
      before do
        @user = User.new(name: '島根太郎', sex: '9')
      end
      it '１または２であること' do
        expect(@user).to_not be_valid
      end
    end
  end
=end
=begin
  #----------------------------------------------------------------------------
  #    名前チェック処理
  #----------------------------------------------------------------------------
  describe '名前チェック処理' do
    context '全角のみ' do
      it 'エラーメッセージが返ってこないこと' do
        msg = User.validate_name("島根太郎")
        expect(msg).to be_nil
      end
    end
    context '半角混在' do
      it 'エラーメッセージが返ってくること' do
        msg = User.validate_name("島根TARO")
        expect(msg).to eq "名前は全角文字を入力してください"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    性別チェック処理
  #----------------------------------------------------------------------------
  describe '性別チェック処理' do
    context '正常1' do
      it 'エラーメッセージが返ってこないこと' do
        msg = User.validate_sex("1")
        expect(msg).to be_nil
      end
    end
    context '正常2' do
      it 'エラーメッセージが返ってこないこと' do
        msg = User.validate_sex("2")
        expect(msg).to be_nil
      end
    end
    context '半角混在' do
      it 'エラーメッセージが返ってくること' do
        msg = User.validate_sex("9")
        expect(msg).to eq "性別は男(1)または女(2)を入力してください"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    生年月日チェック処理
  #----------------------------------------------------------------------------
  describe '生年月日チェック処理' do
    context '正常' do
      it 'エラーメッセージが返ってこないこと' do
        msg = User.validate_birth("19590514")
        expect(msg).to be_nil
      end
    end
    context '存在しない日付' do
      it 'エラーメッセージが返ってくること' do
        msg = User.validate_birth("20140230")
        expect(msg).to eq "生年月日が存在しない日付です"
      end
    end
    context '形式不備' do
      it 'エラーメッセージが返ってくること' do
        msg = User.validate_birth("201411")
        expect(msg).to eq "生年月日が存在しない日付です"
      end
    end
  end
  #----------------------------------------------------------------------------
  #    メールアドレスチェック処理
  #----------------------------------------------------------------------------
  describe 'メールアドレスチェック処理' do
    context '正常' do
      it 'エラーメッセージが返ってこないこと' do
        msg = User.validate_email("test@sys-link.jp")
        expect(msg).to be_nil
      end
    end
    context '形式不備' do
      it 'エラーメッセージが返ってくること' do
        msg = User.validate_email("11111")
        expect(msg).to eq "メールアドレスの形式が誤っています。"
      end
    end
  end
=end
  #----------------------------------------------------------------------------
  #    名前チェック処理
  #----------------------------------------------------------------------------
  describe '名前チェック処理' do
    context '全角のみ' do
      it 'エラーメッセージが返ってこないこと' do
        para = ('あ,1,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        msg = csvfile.validate_name("島根太郎")
        expect(msg).to be_nil
      end
    end
    context '半角混在' do
      it 'エラーメッセージが返ってくること' do
        para = ('あ,1,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        msg = csvfile.validate_name("島根TARO")
        expect(msg).to eq ["名前は全角文字を入力してください"]
      end
    end
  end
  #----------------------------------------------------------------------------
  #    性別チェック処理
  #----------------------------------------------------------------------------
  describe '性別チェック処理' do
    context '正常1' do
      it 'エラーメッセージが返ってこないこと' do
        para = ('あ,1,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        msg = csvfile.validate_sex("1")
        expect(msg).to be_nil
      end
    end
    context '正常2' do
      it 'エラーメッセージが返ってこないこと' do
        para = ('あ,1,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        msg = csvfile.validate_sex("2")
        expect(msg).to be_nil
      end
    end
    context 'エラー' do
      it 'エラーメッセージが返ってくること' do
        para = ('あ,1,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        msg = csvfile.validate_sex("9")
        expect(msg).to eq ["性別は男(1)または女(2)を入力してください"]
      end
    end
  end
  #----------------------------------------------------------------------------
  #    生年月日チェック処理
  #----------------------------------------------------------------------------
  describe '生年月日チェック処理' do
    context '正常' do
      it 'エラーメッセージが返ってこないこと' do
        para = ('あ,1,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        msg = csvfile.validate_birth("19590514")
        expect(msg).to be_nil
      end
    end
    context '存在しない日付' do
      it 'エラーメッセージが返ってくること' do
        para = ('あ,1,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        msg = csvfile.validate_birth("20140230")
        expect(msg).to eq ["生年月日が存在しない日付です"]
      end
    end
    context '形式不備' do
      it 'エラーメッセージが返ってくること' do
        para = ('あ,1,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        msg = csvfile.validate_birth("201411")
        expect(msg).to eq ["生年月日が存在しない日付です"]
      end
    end
  end
  #----------------------------------------------------------------------------
  #    メールアドレスチェック処理
  #----------------------------------------------------------------------------
  describe 'メールアドレスチェック処理' do
    context '正常' do
      it 'エラーメッセージが返ってこないこと' do
        para = ('あ,1,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        msg = csvfile.validate_email("test@sys-link.jp")
        expect(msg).to be_nil
      end
    end
    context '形式不備' do
      it 'エラーメッセージが返ってくること' do
        para = ('あ,1,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        msg = csvfile.validate_email("11111")
        expect(msg).to eq ["メールアドレスの形式が誤っています。"]
      end
    end
  end
  #----------------------------------------------------------------------------
  #    コンストラクタのチェック処理
  #----------------------------------------------------------------------------
  describe 'コンストラクタのチェック処理' do
    context '名前のエラー' do
      it 'エラーメッセージが返ってくること' do
        para = ('a,1,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        expect(csvfile.errors.full_messages[0]).to eq "Name名前は全角文字を入力してください"
      end
    end
    context '性別のエラー' do
      it 'エラーメッセージが返ってくること' do
        para = ('あ,9,20140730,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        expect(csvfile.errors.full_messages[0]).to eq "Sex性別は男(1)または女(2)を入力してください"
      end
    end
    context '生年月日のエラー（非実在日）' do
      it 'エラーメッセージが返ってくること' do
        para = ('あ,1,20140230,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        expect(csvfile.errors.full_messages[0]).to eq "Birth生年月日が存在しない日付です"
      end
    end
    context '生年月日のエラー（形式不備）' do
      it 'エラーメッセージが返ってくること' do
        para = ('あ,1,201411,test@test.co.jp').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        expect(csvfile.errors.full_messages[0]).to eq "Birth生年月日が存在しない日付です"
      end
    end
    context 'メールアドレスのエラー' do
      it 'エラーメッセージが返ってくること' do
        para = ('あ,1,20140730,11111').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        expect(csvfile.errors.full_messages[0]).to eq "Emailメールアドレスの形式が誤っています。"
      end
    end
    context '複数件のエラー' do
      it 'エラーメッセージが返ってくること' do
        para = ('1,1,20140730,11111').encode("windows-31j","utf-8")
        csvfile = CsvFile2.new(para)
        expect(csvfile.errors.full_messages).to match_array(
              ["Name名前は全角文字を入力してください", "Emailメールアドレスの形式が誤っています。"])
      end
    end
  end
end
