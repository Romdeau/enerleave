class FlightsController < ApplicationController
  before_action :set_flight, only: [:show, :edit, :update, :destroy, :approve, :approval]

  # GET /flights
  # GET /flights.json
  def index
    @flights = Flight.all
  end

  # GET /flights/1
  # GET /flights/1.json
  def show
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
  end

  # GET /flights/new
  def new
    @flight = Flight.new
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @accommodations = @travel_leg.accommodation.reorder("check_in ASC")
    @car_hires = @travel_leg.car_hire.reorder("pickup_date ASC")
    @flights =  @travel_leg.flight.reorder("flight_date ASC")
  end

  # GET /flights/1/edit
  def edit

  end

  # POST /flights
  # POST /flights.json
  def create
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    @accommodations = @travel_leg.accommodation
    @car_hires = @travel_leg.car_hire
    @flights =  @travel_leg.flight
    @flight = Flight.new(flight_params)
    @flight.travel_leg = @travel_leg
    @flight.booked = false
    respond_to do |format|
      if @flight.save
        format.html { redirect_to travel_request_travel_leg_path(@travel_request, @travel_leg), notice: 'Flight was successfully created.' }
        format.json { render action: 'show', status: :created, location: @flight }
      else
        format.html { render action: 'new' }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flights/1
  # PATCH/PUT /flights/1.json
  def update
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to travel_request_travel_leg_flight_path(@travel_request, @travel_leg, @flight), notice: 'Flight was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1
  # DELETE /flights/1.json
  def destroy
    @travel_leg = @flight.travel_leg
    @travel_request = @travel_leg.travel_request
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to travel_request_travel_leg_path(@travel_request, @travel_leg) }
      format.json { head :no_content }
    end
  end

  def approve
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
  end

  def approval
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    @flight.booked = true
    @flight.booking_comment = flight_params[:booking_comment]
    respond_to do |format|
      if @flight.save
        format.html { redirect_to travel_request_travel_leg_flight_path(@travel_request, @travel_leg, @flight), notice: 'Flight was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flight_params
      params.require(:flight).permit(:takeoff_location, :landing_location, :flight_date, :comment, :booked, :booking_comment)
    end
end
