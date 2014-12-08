class TravelRequestsController < ApplicationController
  before_action :set_travel_request, only: [:show, :edit, :update, :destroy, :approve, :itinerary]
  before_filter :require_login, except: [:index, :show]

  # GET /travel_requests
  # GET /travel_requests.json
  def index
    @travel_requests = TravelRequest.all
  end

  # GET /travel_requests/1
  # GET /travel_requests/1.json
  def show
    @travel_legs = @travel_request.travel_leg.reorder("date_start ASC")
  end

  # GET /travel_requests/new
  def new
    @travel_request = TravelRequest.new
  end

  def new_destination
    @travel_request = TravelRequest.new
  end

  # GET /travel_requests/1/edit
  def edit

  end

  # POST /travel_requests
  # POST /travel_requests.json
  def create
    @travel_request = TravelRequest.new
    @travel_request.comment = travel_request_params[:comment]
    @travel_leg = TravelLeg.new
    @travel_leg.travel_request = @travel_request
    @travel_leg.date_start = travel_request_params[:flight_date]
    @travel_leg.destination_city = travel_request_params[:destination]
    @travel_leg.comment = travel_request_params[:flight_comment]
    @travel_leg.destination_type = "flight"
    @travel_leg.booking_status = "unbooked"
    @flight = Flight.new
    @flight.travel_leg = @travel_leg
    @flight.landing_location = travel_request_params[:destination]
    @flight.flight_date = travel_request_params[:flight_date]
    @flight.booked = false
    @travel_request.user = current_user
    respond_to do |format|
      if @travel_request.save && @travel_leg.save && @flight.save
        format.html { redirect_to @travel_request, notice: 'Travel request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @travel_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @travel_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_destination
    @travel_request = TravelRequest.new
    @travel_request.comment = travel_request_params[:comment]
    @travel_leg = TravelLeg.new
    @travel_leg.travel_request = @travel_request
    @travel_leg.date_start = travel_request_params[:flight_date]
    @travel_leg.destination_city = travel_request_params[:destination]
    @travel_leg.comment = travel_request_params[:flight_comment]
    @travel_leg.destination_type = "destination"
    @travel_leg.booking_status = "unbooked"
    @travel_request.user = current_user
    respond_to do |format|
      if @travel_request.save && @travel_leg.save
        format.html { redirect_to @travel_request, notice: 'Travel request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @travel_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @travel_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /travel_requests/1
  # PATCH/PUT /travel_requests/1.json
  def update
    respond_to do |format|
      if @travel_request.update(travel_request_params)
        format.html { redirect_to @travel_request, notice: 'Travel request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @travel_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travel_requests/1
  # DELETE /travel_requests/1.json
  def destroy
    @travel_request.destroy
    respond_to do |format|
      format.html { redirect_to travel_requests_url }
      format.json { head :no_content }
    end
  end

  def lodge
    @travel_request = TravelRequest.find(params[:id])
    UserMailer.lodge_travel_request(@travel_request.user, @travel_request).deliver
    @travel_request.lodged = true
    if @travel_request.save
      redirect_to @travel_request, notice: 'Travel request was successfully lodged.'
    else
      redirect_to @travel_request, notice: 'Hrm, something went wrong.'
    end
  end

  def manager_approve
    @travel_request = TravelRequest.find(params[:id])
    UserMailer.approve_travel_request(current_user, @travel_request).deliver
    @travel_request.manager_approved = true
    if @travel_request.save
      redirect_to @travel_request, notice: 'Travel request has been approved by a manager.'
    else
      redirect_to @travel_request, notice: 'Hrm, something went wrong.'
    end
  end

  def complete_booking
    @travel_request = TravelRequest.find(params[:id])
    UserMailer.booked_travel_request(@travel_request.user, @travel_request).deliver
    @travel_request.fully_booked = true
    if @travel_request.save
      redirect_to @travel_request, notice: 'Travel request has been booked.'
    else
      redirect_to @travel_request, notice: 'Hrm, something went wrong.'
    end
  end

  def itinerary
    render "travel_requests/itinerary", :layout => false
    @travel_legs = @travel_request.travel_leg
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_travel_request
      @travel_request = TravelRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def travel_request_params
      params.require(:travel_request).permit(:destination, :flight_date, :flight_comment, :comment)
    end
end
