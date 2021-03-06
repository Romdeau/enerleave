class TravelLegsController < ApplicationController
  before_action :set_travel_leg, only: [:show, :edit, :update, :destroy, :add_user, :approve_user, :remove_user, :destroy_user]
  before_filter :require_login
  # GET /travel_legs
  # GET /travel_legs.json
  def index
    @travel_legs = TravelLeg.all
  end

  # GET /travel_legs/1
  # GET /travel_legs/1.json
  def show
    @travel_request = TravelRequest.find(params[:travel_request_id])
    if @travel_request.lodged == true
      redirect_to travel_request_path(@travel_request)
    else
      @accommodations = @travel_leg.accommodation.reorder("check_in ASC")
      @car_hires = @travel_leg.car_hire.reorder("pickup_date ASC")
      @flights =  @travel_leg.flight.reorder("flight_date ASC")
    end
  end

  # GET /travel_legs/new
  def new
    @travel_leg = TravelLeg.new
    @travel_request = TravelRequest.find(params[:travel_request_id])
  end

  def new_destination
    @travel_leg = TravelLeg.new
    @travel_request = TravelRequest.find(params[:travel_request_id])
  end

  # GET /travel_legs/1/edit
  def edit
    @formatted_start_date = @travel_leg.date_start.strftime('%d/%m/%Y')
    @formatted_end_date = @travel_leg.date_end.strftime('%d/%m/%Y')
  end

  # POST /travel_legs
  # POST /travel_legs.json
  def create
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.new(travel_leg_params)
    @travel_leg.travel_request = @travel_request
    @flight = Flight.new
    @flight.travel_leg = @travel_leg
    @flight.landing_location = travel_leg_params[:destination_city]
    @flight.flight_date = travel_leg_params[:date_start]
    @flight.booked = false
    respond_to do |format|
      if @travel_leg.save && @flight.save
        format.html { redirect_to @travel_request, notice: 'Travel leg was successfully created.' }
        format.json { render action: 'show', status: :created, location: @travel_leg }
      else
        format.html { render action: 'new' }
        format.json { render json: @travel_leg.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_destination
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.new(travel_leg_params)
    @travel_leg.travel_request = @travel_request
    respond_to do |format|
      if @travel_leg.save
        format.html { redirect_to @travel_request, notice: 'Travel leg was successfully created.' }
        format.json { render action: 'show', status: :created, location: @travel_leg }
      else
        format.html { render action: 'new' }
        format.json { render json: @travel_leg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /travel_legs/1
  # PATCH/PUT /travel_legs/1.json
  def update
    @travel_request = @travel_leg.travel_request
    respond_to do |format|
      if @travel_leg.update(travel_leg_params)
        format.html { redirect_to travel_request_travel_leg_path(@travel_request, @travel_leg), notice: 'Travel leg was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @travel_leg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travel_legs/1
  # DELETE /travel_legs/1.json
  def destroy
    @travel_request = @travel_leg.travel_request
    @travel_leg.destroy
    respond_to do |format|
      format.html { redirect_to travel_request_path(@travel_request) }
      format.json { head :no_content }
    end
  end

  def add_user
    @users = User.all
  end

  def approve_user
    @user = User.find(params[:user_id])
    if @travel_leg.user.exists?(@user) == false
      @travel_leg.user << @user
    end
    if @travel_leg.save
      redirect_to travel_request_travel_leg_path(params[:travel_request_id], @travel_leg), notice: 'User was successfully added to travel leg.'
    end
  end

  def remove_user
    @users = @travel_leg.user
  end

  def destroy_user
    @user = User.find(params[:user_id])
    if @travel_leg.user.exists?(@user)
      @travel_leg.user.delete(@user)
    end
    if @travel_leg.save
      redirect_to travel_request_travel_leg_path(params[:travel_request_id], @travel_leg), notice: 'User was successfully removed from the travel leg.'
    end
  end

  def complete_booking
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    @travel_leg.fully_booked = true
    if @travel_leg.save
      redirect_to travel_request_travel_leg_path(params[:travel_request_id], @travel_leg), notice: 'Travel Leg was successfully updated.'
    else
      redirect_to travel_request_travel_leg_path(params[:travel_request_id], @travel_leg), notice: 'Hrm, something went wrong.'
    end
  end

  def undo_booking
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    @travel_leg.fully_booked = false
    if @travel_leg.save
      redirect_to travel_request_travel_leg_path(params[:travel_request_id], @travel_leg), notice: 'Travel Leg was set back to unbooked.'
    else
      redirect_to travel_request_travel_leg_path(params[:travel_request_id], @travel_leg), notice: 'Hrm, something went wrong.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_travel_leg
      @travel_leg = TravelLeg.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def travel_leg_params
      params.require(:travel_leg).permit(:date_start, :date_end, :destination_address, :destination_suburb, :destination_city, :destination_state, :destination_postcode)
    end
end
