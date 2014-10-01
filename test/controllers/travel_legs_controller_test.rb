require 'test_helper'

class TravelLegsControllerTest < ActionController::TestCase
  setup do
    @travel_leg = travel_legs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travel_legs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travel_leg" do
    assert_difference('TravelLeg.count') do
      post :create, travel_leg: { accommodation: @travel_leg.accommodation, accommodation: @travel_leg.accommodation, car: @travel_leg.car, car_comment: @travel_leg.car_comment, date_end: @travel_leg.date_end, date_start: @travel_leg.date_start, flight: @travel_leg.flight, flight_comment: @travel_leg.flight_comment }
    end

    assert_redirected_to travel_leg_path(assigns(:travel_leg))
  end

  test "should show travel_leg" do
    get :show, id: @travel_leg
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @travel_leg
    assert_response :success
  end

  test "should update travel_leg" do
    patch :update, id: @travel_leg, travel_leg: { accommodation: @travel_leg.accommodation, accommodation: @travel_leg.accommodation, car: @travel_leg.car, car_comment: @travel_leg.car_comment, date_end: @travel_leg.date_end, date_start: @travel_leg.date_start, flight: @travel_leg.flight, flight_comment: @travel_leg.flight_comment }
    assert_redirected_to travel_leg_path(assigns(:travel_leg))
  end

  test "should destroy travel_leg" do
    assert_difference('TravelLeg.count', -1) do
      delete :destroy, id: @travel_leg
    end

    assert_redirected_to travel_legs_path
  end
end
