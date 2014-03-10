require 'test_helper'

class TimeitemsControllerTest < ActionController::TestCase
  setup do
    @timeitem = timeitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:timeitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create timeitem" do
    assert_difference('Timeitem.count') do
      post :create, timeitem: { cost_center_id: @timeitem.cost_center_id, description: @timeitem.description, end_time: @timeitem.end_time, project_id: @timeitem.project_id, start_time: @timeitem.start_time, timesheet_id: @timeitem.timesheet_id, user_id: @timeitem.user_id }
    end

    assert_redirected_to timeitem_path(assigns(:timeitem))
  end

  test "should show timeitem" do
    get :show, id: @timeitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @timeitem
    assert_response :success
  end

  test "should update timeitem" do
    patch :update, id: @timeitem, timeitem: { cost_center_id: @timeitem.cost_center_id, description: @timeitem.description, end_time: @timeitem.end_time, project_id: @timeitem.project_id, start_time: @timeitem.start_time, timesheet_id: @timeitem.timesheet_id, user_id: @timeitem.user_id }
    assert_redirected_to timeitem_path(assigns(:timeitem))
  end

  test "should destroy timeitem" do
    assert_difference('Timeitem.count', -1) do
      delete :destroy, id: @timeitem
    end

    assert_redirected_to timeitems_path
  end
end
