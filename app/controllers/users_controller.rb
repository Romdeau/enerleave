class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :zero_users_or_authenticated, only: [:new, :create]
  before_filter :require_login, except: [:new, :create]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @toil_requests = User.find(params[:id]).toil_request
    @leave_requests = User.find(params[:id]).leave_request
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def role
    @user = User.find(params[:id])
  end

  def manager_email
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if User.count == 0
      @user.role = 'admin'
    else
      @user.role = "user"
    end

    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver
        format.html { redirect_to :users, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_role
    @user = User.find(params[:id])
    @old_role = @user.role
    user_params.delete(:password)
    user_params.delete(:password_confirmation)
    if @user.update_many_attributes(user_params)
      UserAudit.create({:user => current_user, :action => "changed user role", :description => "Role changed from #{@old_role} to #{@user.role}", :end_user => @user.email})
      redirect_to @user, notice: 'Manager Email successfully updated.'
    else
      render action: 'role'
    end
  end

  def update_manager_email
    @user = User.find(params[:id])
    user_params.delete(:password)
    user_params.delete(:password_confirmation)
    if @user.update_many_attributes(user_params)
      @user.check_manager
      UserAudit.create({:user => current_user, :action => "updatedted manager email", :end_user => @user.email})
      UserMailer.assign_manager(@user).deliver
      redirect_to @user, notice: 'Manager Email successfully updated.'
    else
      render action: 'role'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    UserAudit.create({:user => current_user, :action => "user destroyed", :end_user => @user.email})
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def toil
    @user = User.find(params[:id])
    @toil_requests = @user.toil_request.reorder("date_accrued_end DESC")
    @spend_toils = @user.spend_toil.reorder("leave_date DESC")
  end

  def leave
    @user = User.find(params[:id])
    @leave_requests = @user.leave_request.reorder("end_date DESC").page(params[:page]).per_page(8)
  end

  def create_toil
    @user = User.find(params[:id])
    @toil_request = ToilRequest.new
    @toil_request.user = @user
    @toil_request.initial_amount = 1
    @toil_request.amount = 1
    @toil_request.date_accrued = Time.now
    @toil_request.date_accrued_end = Time.now
    @toil_request.approved = 'false'
    if @toil_request.save
      UserAudit.create({:user => current_user, :action => "created toil request while impersonating user", :end_user => @user.email})
      redirect_to edit_toil_request_path(@toil_request), notice:"Toil request created as #{@user.email}", alert:"remember to enter toil value in total minutes"
    else
      render action: 'toil', alert: "Something went wrong"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role, :manager_email)
    end

    def not_authenticated
      redirect_to login_path, alert: "Please login first"
    end

    def zero_users_or_authenticated
    unless User.count == 0 || current_user
      redirect_to login_path
      return false
    end
  end
end
