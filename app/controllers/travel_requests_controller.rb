class TravelRequestsController < ApplicationController
  before_action :set_travel_request, only: [:show, :edit, :update, :destroy, :approve]
  before_filter :require_login, except: [:index, :show]

  # GET /travel_requests
  # GET /travel_requests.json
  def index
    @travel_requests = TravelRequest.all
  end

  # GET /travel_requests/1
  # GET /travel_requests/1.json
  def show
    @travel_legs = @travel_request.travel_leg
  end

  # GET /travel_requests/new
  def new
    @travel_request = TravelRequest.new
  end

  # GET /travel_requests/1/edit
  def edit
    @formatted_start_date = @travel_request.start_date.strftime('%d/%m/%Y')
    @formatted_end_date = @travel_request.end_date.strftime('%d/%m/%Y')
  end

  # POST /travel_requests
  # POST /travel_requests.json
  def create
    @travel_request = TravelRequest.new(travel_request_params)
    @travel_request.user = current_user
    respond_to do |format|
      if @travel_request.save
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
    UserMailer.lodge_travel_request(current_user, @travel_request).deliver
    @travel_request.lodged = true
    if @travel_request.save
      redirect_to @travel_request, notice: 'Travel request was successfully updated.'
    else
      redirect_to @travel_request, notice: 'Hrm, something went wrong.'
    end
  end

  def complete_booking
    @travel_request = TravelRequest.find(params[:id])
    @travel_request.fully_booked = true
    if @travel_request.save
      redirect_to @travel_request, notice: 'Travel request was successfully updated.'
    else
      redirect_to @travel_request, notice: 'Hrm, something went wrong.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_travel_request
      @travel_request = TravelRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def travel_request_params
      params.require(:travel_request).permit(:start_date, :end_date, :comment)
    end
end