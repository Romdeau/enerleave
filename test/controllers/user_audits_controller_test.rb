require 'test_helper'

class UserAuditsControllerTest < ActionController::TestCase
  setup do
    @user_audit = user_audits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_audits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_audit" do
    assert_difference('UserAudit.count') do
      post :create, user_audit: { action: @user_audit.action, description: @user_audit.description, end_user: @user_audit.end_user, user_id: @user_audit.user_id }
    end

    assert_redirected_to user_audit_path(assigns(:user_audit))
  end

  test "should show user_audit" do
    get :show, id: @user_audit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_audit
    assert_response :success
  end

  test "should update user_audit" do
    patch :update, id: @user_audit, user_audit: { action: @user_audit.action, description: @user_audit.description, end_user: @user_audit.end_user, user_id: @user_audit.user_id }
    assert_redirected_to user_audit_path(assigns(:user_audit))
  end

  test "should destroy user_audit" do
    assert_difference('UserAudit.count', -1) do
      delete :destroy, id: @user_audit
    end

    assert_redirected_to user_audits_path
  end
end
