require 'test_helper'

class GiftMastersControllerTest < ActionController::TestCase
  setup do
    @gift_master = gift_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gift_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gift_master" do
    assert_difference('GiftMaster.count') do
      post :create, gift_master: { amount: @gift_master.amount, condition: @gift_master.condition, condition_year: @gift_master.condition_year, div: @gift_master.div, year_flg: @gift_master.year_flg }
    end

    assert_redirected_to gift_master_path(assigns(:gift_master))
  end

  test "should show gift_master" do
    get :show, id: @gift_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gift_master
    assert_response :success
  end

  test "should update gift_master" do
    patch :update, id: @gift_master, gift_master: { amount: @gift_master.amount, condition: @gift_master.condition, condition_year: @gift_master.condition_year, div: @gift_master.div, year_flg: @gift_master.year_flg }
    assert_redirected_to gift_master_path(assigns(:gift_master))
  end

  test "should destroy gift_master" do
    assert_difference('GiftMaster.count', -1) do
      delete :destroy, id: @gift_master
    end

    assert_redirected_to gift_masters_path
  end
end
