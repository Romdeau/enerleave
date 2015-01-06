class CarHiresController < ApplicationController
  before_action :set_car_hire, only: [:show, :edit, :update, :destroy, :approve, :approval]

  # GET /car_hires
  # GET /car_hires.json
  def index
    @car_hires = CarHire.all
  end

  # GET /car_hires/1
  # GET /car_hires/1.json
  def show
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
  end

  # GET /car_hires/new
  def new
    @car_hire = CarHire.new
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    @travel_request = @travel_leg.travel_request
    @accommodations = @travel_leg.accommodation.reorder("check_in ASC")
    @car_hires = @travel_leg.car_hire.reorder("pickup_date ASC")
    @flights =  @travel_leg.flight.reorder("flight_date ASC")
  end

  # GET /car_hires/1/edit
  def edit
    @formatted_hire_date = @car_hire.pickup_date.strftime('%d/%m/%Y')
    @formatted_return_date = @car_hire.dropoff_date.strftime('%d/%m/%Y')
  end

  # POST /car_hires
  # POST /car_hires.json
  def create
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    @accommodations = @travel_leg.accommodation
    @car_hires = @travel_leg.car_hire
    @flights =  @travel_leg.flight
    @car_hire = CarHire.new(car_hire_params)
    @car_hire.travel_leg = @travel_leg
    @car_hire.booked = false
    respond_to do |format|
      if @car_hire.save
        format.html { redirect_to travel_request_travel_leg_path(@travel_request, @travel_leg), notice: 'Car hire was successfully created.' }
        format.json { render action: 'show', status: :created, location: @car_hire }
      else
        format.html { render action: 'new' }
        format.json { render json: @car_hire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /car_hires/1
  # PATCH/PUT /car_hires/1.json
  def update
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    respond_to do |format|
      if @car_hire.update(car_hire_params)
        format.html { redirect_to travel_request_travel_leg_car_hire_path(@travel_request, @travel_leg, @car_hire), notice: 'Car hire was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @car_hire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /car_hires/1
  # DELETE /car_hires/1.json
  def destroy
    @car_hire.destroy
    respond_to do |format|
      format.html { redirect_to car_hires_url }
      format.json { head :no_content }
    end
  end

  def approve
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
  end

  def approval
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    @car_hire.booked = true
    @car_hire.booking_comment = car_hire_params[:booking_comment]
    respond_to do |format|
      if @car_hire.save
        format.html { redirect_to travel_request_travel_leg_car_hire_path(@travel_request, @travel_leg, @car_hire), notice: 'Car hire was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @car_hire.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_hire
      @car_hire = CarHire.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_hire_params
      params.require(:car_hire).permit(:driver, :pickup_location, :pickup_date, :dropoff_date, :dropoff_location, :comment, :booked, :booking_comment)
    end
end
