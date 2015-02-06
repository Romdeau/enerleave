class TravelRequestsController < ApplicationController
  before_action :set_travel_request, only: [:show, :edit, :update, :destroy, :approve, :itinerary]
  before_filter :require_login

  # GET /travel_requests
  # GET /travel_requests.json
  def index
    @travel_requests = TravelRequest.all
  end

  # GET /travel_requests/1
  # GET /travel_requests/1.json
  def show
    if @travel_request.lodged != true
      @travel_leg = @travel_request.travel_leg[0]
      redirect_to travel_request_travel_leg_path(@travel_request.id, @travel_leg.id)
    else
      @travel_leg = @travel_request.travel_leg[0]
      @accommodations = @travel_leg.accommodation.reorder("check_in ASC")
      @car_hires = @travel_leg.car_hire.reorder("pickup_date ASC")
      @flights =  @travel_leg.flight.reorder("flight_date ASC")
    end
  end

  # GET /travel_requests/new
  def new
    @travel_request = TravelRequest.new
    @users = User.all
  end

  def new_destination
    @travel_request = TravelRequest.new
    @users = User.all
  end

  # GET /travel_requests/1/edit
  def edit

  end

  # POST /travel_requests
  # POST /travel_requests.json
  def create
    @users = Users.all
    @traveller = travel_request_params[:user_id]
    @travel_request = TravelRequest.new
    @travel_request.comment = travel_request_params[:comment]
    @travel_request.user_id = current_user.id
    @travel_request.lodged = false
    @travel_leg = TravelLeg.new
    @travel_leg.travel_request = @travel_request
    @travel_leg.user << @travel_request.user
    respond_to do |format|
      if @travel_request.save
        format.html { redirect_to travel_request_travel_leg_path(@travel_request, @travel_leg), notice: 'Travel request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @travel_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @travel_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_destination
    @users = User.all
    @travel_request = TravelRequest.new
    @travel_request.comment = travel_request_params[:comment]
    @travel_request.user_id = travel_request_params[:user_id]
    @travel_request.lodged = false
    @travel_leg = TravelLeg.new
    @travel_leg.travel_request = @travel_request
    @travel_leg.user << @travel_request.user
    respond_to do |format|
      if @travel_request.save && @travel_leg.save
        format.html { redirect_to travel_request_travel_leg_path(@travel_request, @travel_leg), notice: 'Travel request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @travel_request }
      else
        format.html { render action: 'new_destination' }
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

  def manager_reject
    @travel_request = TravelRequest.find(params[:id])
    @travel_leg = @travel_request.travel_leg[0]
    @accommodations = @travel_leg.accommodation.reorder("check_in ASC")
    @car_hires = @travel_leg.car_hire.reorder("pickup_date ASC")
    @flights =  @travel_leg.flight.reorder("flight_date ASC")
  end

  def manager_process_reject
    @travel_request = TravelRequest.find(params[:id])
    @travel_leg_params = params[:travel_leg]
    @travel_request.lodged = false
    @rejection_comment = @travel_leg_params[:comment]
    UserMailer.reject_travel_request(@travel_request, current_user, @rejection_comment).deliver
    if @travel_request.save
      redirect_to @travel_request, notice: 'Travel request has been rejected.'
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
      params.require(:travel_request).permit(:user_id, :destination, :flight_date, :flight_comment, :comment)
    end
end
