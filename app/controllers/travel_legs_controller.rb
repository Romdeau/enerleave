class TravelLegsController < ApplicationController
  before_action :set_travel_leg, only: [:show, :edit, :update, :destroy]

  # GET /travel_legs
  # GET /travel_legs.json
  def index
    @travel_legs = TravelLeg.all
  end

  # GET /travel_legs/1
  # GET /travel_legs/1.json
  def show
    @flights = @travel_leg.flight
    @accommodation = @travel_leg.accommodation
    @car_hire = @travel_leg.car_hire
  end

  # GET /travel_legs/new
  def new
    @travel_leg = TravelLeg.new
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
    respond_to do |format|
      if @travel_leg.update(travel_leg_params)
        format.html { redirect_to @travel_leg, notice: 'Travel leg was successfully updated.' }
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
    @travel_leg.destroy
    respond_to do |format|
      format.html { redirect_to travel_legs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_travel_leg
      @travel_leg = TravelLeg.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def travel_leg_params
      params.require(:travel_leg).permit(:date_start, :date_end, :flight, :flight_comment, :car, :car_comment, :accommodation, :accommodation)
    end
end
