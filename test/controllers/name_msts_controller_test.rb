require 'test_helper'

class NameMstsControllerTest < ActionController::TestCase
  setup do
    @name_mst = name_msts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:name_msts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create name_mst" do
    assert_difference('NameMst.count') do
      post :create, name_mst: { code: @name_mst.code, code_id: @name_mst.code_id, code_id_name: @name_mst.code_id_name, name: @name_mst.name }
    end

    assert_redirected_to name_mst_path(assigns(:name_mst))
  end

  test "should show name_mst" do
    get :show, id: @name_mst
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @name_mst
    assert_response :success
  end

  test "should update name_mst" do
    patch :update, id: @name_mst, name_mst: { code: @name_mst.code, code_id: @name_mst.code_id, code_id_name: @name_mst.code_id_name, name: @name_mst.name }
    assert_redirected_to name_mst_path(assigns(:name_mst))
  end

  test "should destroy name_mst" do
    assert_difference('NameMst.count', -1) do
      delete :destroy, id: @name_mst
    end

    assert_redirected_to name_msts_path
  end
end
