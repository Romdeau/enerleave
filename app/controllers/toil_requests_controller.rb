class ToilRequestsController < ApplicationController
  before_action :set_toil_request, only: [:show, :edit, :update, :destroy]

  # GET /toil_requests
  # GET /toil_requests.json
  def index
    @toil_requests = ToilRequest.all
  end

  # GET /toil_requests/1
  # GET /toil_requests/1.json
  def show
  end

  # GET /toil_requests/new
  def new
    @toil_request = ToilRequest.new
  end

  # GET /toil_requests/1/edit
  def edit
  end

  # POST /toil_requests
  # POST /toil_requests.json
  def create
    @toil_request = ToilRequest.new(toil_request_params)

    respond_to do |format|
      if @toil_request.save
        format.html { redirect_to @toil_request, notice: 'Toil request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @toil_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @toil_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /toil_requests/1
  # PATCH/PUT /toil_requests/1.json
  def update
    respond_to do |format|
      if @toil_request.update(toil_request_params)
        format.html { redirect_to @toil_request, notice: 'Toil request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @toil_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /toil_requests/1
  # DELETE /toil_requests/1.json
  def destroy
    @toil_request.destroy
    respond_to do |format|
      format.html { redirect_to toil_requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_toil_request
      @toil_request = ToilRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def toil_request_params
      params.require(:toil_request).permit(:user_id, :claim_date, :claim_hours, :approver_id)
    end
end
