class TimeweeksController < ApplicationController
  before_action :set_timeweek, only: [:show, :edit, :update, :destroy]

  # GET /timeweeks
  # GET /timeweeks.json
  def index
    @timeweeks = Timeweek.all
  end

  # GET /timeweeks/1
  # GET /timeweeks/1.json
  def show
  end

  # GET /timeweeks/new
  def new
    @timeweek = Timeweek.new
  end

  # GET /timeweeks/1/edit
  def edit
  end

  # POST /timeweeks
  # POST /timeweeks.json
  def create
    @timeweek = Timeweek.new(timeweek_params)

    respond_to do |format|
      if @timeweek.save
        format.html { redirect_to @timeweek, notice: 'Timeweek was successfully created.' }
        format.json { render action: 'show', status: :created, location: @timeweek }
      else
        format.html { render action: 'new' }
        format.json { render json: @timeweek.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timeweeks/1
  # PATCH/PUT /timeweeks/1.json
  def update
    respond_to do |format|
      if @timeweek.update(timeweek_params)
        format.html { redirect_to @timeweek, notice: 'Timeweek was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @timeweek.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timeweeks/1
  # DELETE /timeweeks/1.json
  def destroy
    @timeweek.destroy
    respond_to do |format|
      format.html { redirect_to timeweeks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timeweek
      @timeweek = Timeweek.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timeweek_params
      params.require(:timeweek).permit(:user_id, :start_date)
    end
end
