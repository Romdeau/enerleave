class HomepageController < ApplicationController
  def index
    @leave_requests = LeaveRequest.approved_leave.reorder("end_date DESC").page(params[:page]).per_page(8)
  end
end
