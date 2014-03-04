require 'test_helper'

class ToilRequestsControllerTest < ActionController::TestCase
  setup do
    @toil_request = toil_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:toil_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create toil_request" do
    assert_difference('ToilRequest.count') do
      post :create, toil_request: { approver_id: @toil_request.approver_id, claim_date: @toil_request.claim_date, claim_hours: @toil_request.claim_hours, user_id: @toil_request.user_id }
    end

    assert_redirected_to toil_request_path(assigns(:toil_request))
  end

  test "should show toil_request" do
    get :show, id: @toil_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @toil_request
    assert_response :success
  end

  test "should update toil_request" do
    patch :update, id: @toil_request, toil_request: { approver_id: @toil_request.approver_id, claim_date: @toil_request.claim_date, claim_hours: @toil_request.claim_hours, user_id: @toil_request.user_id }
    assert_redirected_to toil_request_path(assigns(:toil_request))
  end

  test "should destroy toil_request" do
    assert_difference('ToilRequest.count', -1) do
      delete :destroy, id: @toil_request
    end

    assert_redirected_to toil_requests_path
  end
end
