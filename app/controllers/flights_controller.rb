class FlightsController < ApplicationController
  before_action :set_flight, only: [:show, :edit, :update, :destroy]

  # GET /flights
  # GET /flights.json
  def index
    @flights = Flight.all
  end

  # GET /flights/1
  # GET /flights/1.json
  def show
  end

  # GET /flights/new
  def new
    @flight = Flight.new
  end

  # GET /flights/1/edit
  def edit
    @formatted_flight_date = @flight.flight_date.strftime('%d/%m/%Y')
    @formatted_return_date = @flight.return_date.strftime('%d/%m/%Y')
  end

  # POST /flights
  # POST /flights.json
  def create
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
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
        format.html { redirect_to travel_request_travel_leg_path(@travel_request, @travel_leg), notice: 'Flight was successfully updated.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flight_params
      params.require(:flight).permit(:preffered_flight, :preffered_time, :takeoff_location, :landing_location, :flight_date, :return, :return_date)
    end
end
