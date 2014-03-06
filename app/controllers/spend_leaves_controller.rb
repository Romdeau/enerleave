class SpendLeavesController < ApplicationController
  before_action :set_spend_leafe, only: [:show, :edit, :update, :destroy]

  # GET /spend_leaves
  # GET /spend_leaves.json
  def index
    @spend_leaves = SpendLeafe.all
  end

  # GET /spend_leaves/1
  # GET /spend_leaves/1.json
  def show
  end

  # GET /spend_leaves/new
  def new
    @spend_leafe = SpendLeafe.new
  end

  # GET /spend_leaves/1/edit
  def edit
  end

  # POST /spend_leaves
  # POST /spend_leaves.json
  def create
    @spend_leafe = SpendLeafe.new(spend_leafe_params)

    respond_to do |format|
      if @spend_leafe.save
        format.html { redirect_to @spend_leafe, notice: 'Spend leafe was successfully created.' }
        format.json { render action: 'show', status: :created, location: @spend_leafe }
      else
        format.html { render action: 'new' }
        format.json { render json: @spend_leafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spend_leaves/1
  # PATCH/PUT /spend_leaves/1.json
  def update
    respond_to do |format|
      if @spend_leafe.update(spend_leafe_params)
        format.html { redirect_to @spend_leafe, notice: 'Spend leafe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @spend_leafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spend_leaves/1
  # DELETE /spend_leaves/1.json
  def destroy
    @spend_leafe.destroy
    respond_to do |format|
      format.html { redirect_to spend_leaves_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spend_leafe
      @spend_leafe = SpendLeafe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spend_leafe_params
      params[:spend_leafe]
    end
end
