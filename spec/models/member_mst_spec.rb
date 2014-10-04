require 'rails_helper'

RSpec.describe MemberMst do

  context "nameが指定されていない場合" do
    before do
      @member = MemberMst.new
    end
    it {expect(@member).to_not be_valid}
  end

  context "nameが指定されている場合" do
    before do
      @member = MemberMst.new(
        menber_name: "島根　太郎"
      )
    end
    it {expect(@member).to be_valid}
  end
end
