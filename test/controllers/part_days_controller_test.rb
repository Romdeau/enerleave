require 'test_helper'

class PartDaysControllerTest < ActionController::TestCase
  setup do
    @part_day = part_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:part_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create part_day" do
    assert_difference('PartDay.count') do
      post :create, part_day: { leave_date: @part_day.leave_date, leave_request_id: @part_day.leave_request_id, time: @part_day.time }
    end

    assert_redirected_to part_day_path(assigns(:part_day))
  end

  test "should show part_day" do
    get :show, id: @part_day
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @part_day
    assert_response :success
  end

  test "should update part_day" do
    patch :update, id: @part_day, part_day: { leave_date: @part_day.leave_date, leave_request_id: @part_day.leave_request_id, time: @part_day.time }
    assert_redirected_to part_day_path(assigns(:part_day))
  end

  test "should destroy part_day" do
    assert_difference('PartDay.count', -1) do
      delete :destroy, id: @part_day
    end

    assert_redirected_to part_days_path
  end
end
