require 'test_helper'

class TimeweeksControllerTest < ActionController::TestCase
  setup do
    @timeweek = timeweeks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:timeweeks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create timeweek" do
    assert_difference('Timeweek.count') do
      post :create, timeweek: { start_date: @timeweek.start_date, user_id: @timeweek.user_id }
    end

    assert_redirected_to timeweek_path(assigns(:timeweek))
  end

  test "should show timeweek" do
    get :show, id: @timeweek
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @timeweek
    assert_response :success
  end

  test "should update timeweek" do
    patch :update, id: @timeweek, timeweek: { start_date: @timeweek.start_date, user_id: @timeweek.user_id }
    assert_redirected_to timeweek_path(assigns(:timeweek))
  end

  test "should destroy timeweek" do
    assert_difference('Timeweek.count', -1) do
      delete :destroy, id: @timeweek
    end

    assert_redirected_to timeweeks_path
  end
end
