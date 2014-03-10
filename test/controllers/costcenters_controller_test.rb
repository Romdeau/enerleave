require 'test_helper'

class CostcentersControllerTest < ActionController::TestCase
  setup do
    @costcenter = costcenters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:costcenters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create costcenter" do
    assert_difference('Costcenter.count') do
      post :create, costcenter: { cost_code: @costcenter.cost_code, description: @costcenter.description }
    end

    assert_redirected_to costcenter_path(assigns(:costcenter))
  end

  test "should show costcenter" do
    get :show, id: @costcenter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @costcenter
    assert_response :success
  end

  test "should update costcenter" do
    patch :update, id: @costcenter, costcenter: { cost_code: @costcenter.cost_code, description: @costcenter.description }
    assert_redirected_to costcenter_path(assigns(:costcenter))
  end

  test "should destroy costcenter" do
    assert_difference('Costcenter.count', -1) do
      delete :destroy, id: @costcenter
    end

    assert_redirected_to costcenters_path
  end
end
