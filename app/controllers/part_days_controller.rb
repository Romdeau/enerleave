class PartDaysController < ApplicationController
  before_action :set_part_day, only: [:show, :edit, :update, :destroy]

  # GET /part_days
  # GET /part_days.json
  def index
    @part_days = PartDay.all
  end

  # GET /part_days/1
  # GET /part_days/1.json
  def show
  end

  # GET /part_days/new
  def new
    @part_day = PartDay.new
  end

  # GET /part_days/1/edit
  def edit
  end

  # POST /part_days
  # POST /part_days.json
  def create
    @part_day = PartDay.new
    @leave_request = LeaveRequest.find(params[:id])
    @part_day.leave_request = @leave_request
    @part_day.leave_date = part_day_params[:leave_request]
    @part_day.time = part_day_params[:time]
    respond_to do |format|
      if @part_day.save
        format.html { redirect_to @part_day, notice: 'Part day was successfully created.' }
        format.json { render action: 'show', status: :created, location: @part_day }
      else
        format.html { render action: 'new' }
        format.json { render json: @part_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /part_days/1
  # PATCH/PUT /part_days/1.json
  def update
    respond_to do |format|
      if @part_day.update(part_day_params)
        format.html { redirect_to @part_day, notice: 'Part day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @part_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /part_days/1
  # DELETE /part_days/1.json
  def destroy
    @part_day.destroy
    respond_to do |format|
      format.html { redirect_to part_days_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_part_day
      @part_day = PartDay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_day_params
      params.require(:part_day).permit(:leave_request_id, :leave_date, :time)
    end
end
