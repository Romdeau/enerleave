class UserAuditsController < ApplicationController
  before_filter :require_login

  # GET /user_audits
  # GET /user_audits.json
  def index
    @user_audits = UserAudit.all
  end

  # GET /user_audits/1
  # GET /user_audits/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_audit
      @user_audit = UserAudit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_audit_params
      params.require(:user_audit).permit(:user_id, :action, :description, :end_user)
    end
end
