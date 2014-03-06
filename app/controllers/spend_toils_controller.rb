class SpendToilsController < ApplicationController
  before_action :set_spend_toil, only: [:show, :edit, :update, :destroy]

  # GET /spend_toils
  # GET /spend_toils.json
  def index
    redirect_to toil_requests_path
  end

  # GET /spend_toils/1
  # GET /spend_toils/1.json
  def show
  end

  # GET /spend_toils/new
  def new
    @spend_toil = SpendToil.new
  end

  # GET /spend_toils/1/edit
  def edit
  end

  # POST /spend_toils
  # POST /spend_toils.json
  def create
    @spend_toil = SpendToil.new(spend_toil_params)
    @spend_toil.initial_amount = @spend_toil.amount
    @spend_toil.user = current_user

    respond_to do |format|
      if @spend_toil.save
        format.html { redirect_to @spend_toil, notice: 'Spend toil was successfully created.' }
        format.json { render action: 'show', status: :created, location: @spend_toil }
      else
        format.html { render action: 'new' }
        format.json { render json: @spend_toil.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spend_toils/1
  # PATCH/PUT /spend_toils/1.json
  def update
    respond_to do |format|
      if @spend_toil.update(spend_toil_params)
        format.html { redirect_to @spend_toil, notice: 'Spend toil was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @spend_toil.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spend_toils/1
  # DELETE /spend_toils/1.json
  def destroy
    @spend_toil.destroy
    respond_to do |format|
      format.html { redirect_to spend_toils_url }
      format.json { head :no_content }
    end
  end

  def approve_toil
    @to_approve = SpendToil.find(params[:id])
    user_approve = User.find(@to_approve.user_id)
    if user_approve.toil_available > @to_approve.amount
      @to_approve.approved = 'true'
      @to_approve.process_leave
      redirect_to toil_requests_path, notice: "Leave successfully processed"
    else
      redirect_to toil_requests_path, alert: 'Not enough toil available'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spend_toil
      @spend_toil = SpendToil.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spend_toil_params
      params.require(:spend_toil).permit(:user_id, :amount, :leave_date, :approved)
    end
end
