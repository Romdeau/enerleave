class AccommodationsController < ApplicationController
  before_action :set_accommodation, only: [:show, :edit, :update, :destroy, :approve, :approval]

  # GET /accommodations
  # GET /accommodations.json
  def index
    @accommodations = Accommodation.all
  end

  # GET /accommodations/1
  # GET /accommodations/1.json
  def show
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
  end

  # GET /accommodations/new
  def new
    @accommodation = Accommodation.new
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    @travel_request = @travel_leg.travel_request
    @formatted_checkin_date = @travel_leg.date_start.strftime('%d/%m/%Y')
  end

  # GET /accommodations/1/edit
  def edit
    @formatted_checkin_date = @accommodation.check_in.strftime('%d/%m/%Y')
    @formatted_checkout_date = @accommodation.check_out.strftime('%d/%m/%Y')
  end

  # POST /accommodations
  # POST /accommodations.json
  def create
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    @accommodation = Accommodation.new(accommodation_params)
    @accommodation.travel_leg = @travel_leg
    @accommodation.booked = false
    respond_to do |format|
      if @accommodation.save
        format.html { redirect_to travel_request_travel_leg_path(@travel_request, @travel_leg), notice: 'Accommodation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @accommodation }
      else
        format.html { render action: 'new' }
        format.json { render json: @accommodation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accommodations/1
  # PATCH/PUT /accommodations/1.json
  def update
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    respond_to do |format|
      if @accommodation.update(accommodation_params)
        format.html { redirect_to travel_request_travel_leg_accommodation_path(@travel_request, @travel_leg, @accommodation), notice: 'Accommodation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @accommodation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accommodations/1
  # DELETE /accommodations/1.json
  def destroy
    @accommodation.destroy
    respond_to do |format|
      format.html { redirect_to accommodations_url }
      format.json { head :no_content }
    end
  end

  def approve
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
  end

  def approval
    @travel_request = TravelRequest.find(params[:travel_request_id])
    @travel_leg = TravelLeg.find(params[:travel_leg_id])
    @accommodation.booked = true
    @accommodation.booking_comment = accommodation_params[:booking_comment]
    respond_to do |format|
      if @accommodation.save
        format.html { redirect_to travel_request_travel_leg_accommodation_path(@travel_request, @travel_leg, @accommodation), notice: 'Accommodation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @accommodation.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accommodation
      @accommodation = Accommodation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accommodation_params
      params.require(:accommodation).permit(:preffered_location, :check_in, :check_out, :comment, :booked, :booking_comment)
    end
end
