class TimeitemsController < ApplicationController
  before_action :set_timeitem, only: [:show, :edit, :update, :destroy]

  # GET /timeitems
  # GET /timeitems.json
  def index
    @timeitems = Timeitem.all
  end

  # GET /timeitems/1
  # GET /timeitems/1.json
  def show
  end

  # GET /timeitems/new
  def new
    @timeitem = Timeitem.new
  end

  # GET /timeitems/1/edit
  def edit
  end

  # POST /timeitems
  # POST /timeitems.json
  def create
    @timeitem = Timeitem.new(timeitem_params)

    respond_to do |format|
      if @timeitem.save
        format.html { redirect_to @timeitem, notice: 'Timeitem was successfully created.' }
        format.json { render action: 'show', status: :created, location: @timeitem }
      else
        format.html { render action: 'new' }
        format.json { render json: @timeitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timeitems/1
  # PATCH/PUT /timeitems/1.json
  def update
    respond_to do |format|
      if @timeitem.update(timeitem_params)
        format.html { redirect_to @timeitem, notice: 'Timeitem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @timeitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timeitems/1
  # DELETE /timeitems/1.json
  def destroy
    @timeitem.destroy
    respond_to do |format|
      format.html { redirect_to timeitems_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timeitem
      @timeitem = Timeitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timeitem_params
      params.require(:timeitem).permit(:user_id, :timesheet_id, :start_time, :end_time, :description, :cost_center_id, :project_id)
    end
end
