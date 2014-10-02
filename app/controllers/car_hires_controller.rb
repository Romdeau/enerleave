class CarHiresController < ApplicationController
  before_action :set_car_hire, only: [:show, :edit, :update, :destroy]

  # GET /car_hires
  # GET /car_hires.json
  def index
    @car_hires = CarHire.all
  end

  # GET /car_hires/1
  # GET /car_hires/1.json
  def show
  end

  # GET /car_hires/new
  def new
    @car_hire = CarHire.new
  end

  # GET /car_hires/1/edit
  def edit
  end

  # POST /car_hires
  # POST /car_hires.json
  def create
    @car_hire = CarHire.new(car_hire_params)

    respond_to do |format|
      if @car_hire.save
        format.html { redirect_to @car_hire, notice: 'Car hire was successfully created.' }
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
    respond_to do |format|
      if @car_hire.update(car_hire_params)
        format.html { redirect_to @car_hire, notice: 'Car hire was successfully updated.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_hire
      @car_hire = CarHire.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_hire_params
      params.require(:car_hire).permit(:driver, :pickup_location, :pickup_date, :dropoff_date, :dropoff_location, :comment)
    end
end
