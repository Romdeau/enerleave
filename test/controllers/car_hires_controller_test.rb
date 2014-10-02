require 'test_helper'

class CarHiresControllerTest < ActionController::TestCase
  setup do
    @car_hire = car_hires(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:car_hires)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create car_hire" do
    assert_difference('CarHire.count') do
      post :create, car_hire: { comment: @car_hire.comment, driver: @car_hire.driver, dropoff_date: @car_hire.dropoff_date, dropoff_location: @car_hire.dropoff_location, pickup_date: @car_hire.pickup_date, pickup_location: @car_hire.pickup_location }
    end

    assert_redirected_to car_hire_path(assigns(:car_hire))
  end

  test "should show car_hire" do
    get :show, id: @car_hire
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @car_hire
    assert_response :success
  end

  test "should update car_hire" do
    patch :update, id: @car_hire, car_hire: { comment: @car_hire.comment, driver: @car_hire.driver, dropoff_date: @car_hire.dropoff_date, dropoff_location: @car_hire.dropoff_location, pickup_date: @car_hire.pickup_date, pickup_location: @car_hire.pickup_location }
    assert_redirected_to car_hire_path(assigns(:car_hire))
  end

  test "should destroy car_hire" do
    assert_difference('CarHire.count', -1) do
      delete :destroy, id: @car_hire
    end

    assert_redirected_to car_hires_path
  end
end
