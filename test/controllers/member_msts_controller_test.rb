require 'test_helper'

class MemberMstsControllerTest < ActionController::TestCase
  setup do
    @member_mst = member_msts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_msts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_mst" do
    assert_difference('MemberMst.count') do
      post :create, member_mst: { admission_date: @member_mst.admission_date, birth_date: @member_mst.birth_date, del_flg: @member_mst.del_flg, enter_date: @member_mst.enter_date, marry_date: @member_mst.marry_date, memo: @member_mst.memo, menber_name: @member_mst.menber_name, menber_no: @member_mst.menber_no, withdrawal_date: @member_mst.withdrawal_date }
    end

    assert_redirected_to member_mst_path(assigns(:member_mst))
  end

  test "should show member_mst" do
    get :show, id: @member_mst
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member_mst
    assert_response :success
  end

  test "should update member_mst" do
    patch :update, id: @member_mst, member_mst: { admission_date: @member_mst.admission_date, birth_date: @member_mst.birth_date, del_flg: @member_mst.del_flg, enter_date: @member_mst.enter_date, marry_date: @member_mst.marry_date, memo: @member_mst.memo, menber_name: @member_mst.menber_name, menber_no: @member_mst.menber_no, withdrawal_date: @member_mst.withdrawal_date }
    assert_redirected_to member_mst_path(assigns(:member_mst))
  end

  test "should destroy member_mst" do
    assert_difference('MemberMst.count', -1) do
      delete :destroy, id: @member_mst
    end

    assert_redirected_to member_msts_path
  end
end
