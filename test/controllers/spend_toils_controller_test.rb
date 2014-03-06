require 'test_helper'

class SpendToilsControllerTest < ActionController::TestCase
  setup do
    @spend_toil = spend_toils(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spend_toils)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spend_toil" do
    assert_difference('SpendToil.count') do
      post :create, spend_toil: {  }
    end

    assert_redirected_to spend_toil_path(assigns(:spend_toil))
  end

  test "should show spend_toil" do
    get :show, id: @spend_toil
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spend_toil
    assert_response :success
  end

  test "should update spend_toil" do
    patch :update, id: @spend_toil, spend_toil: {  }
    assert_redirected_to spend_toil_path(assigns(:spend_toil))
  end

  test "should destroy spend_toil" do
    assert_difference('SpendToil.count', -1) do
      delete :destroy, id: @spend_toil
    end

    assert_redirected_to spend_toils_path
  end
end
