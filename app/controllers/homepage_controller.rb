class HomepageController < ApplicationController
  def index
    @leave_requests = LeaveRequest.approved_leave.reorder("end_date DESC")#.page(params[:page]).per_page(8)
  end

  def approved_select

  end

  def approved_filter
    @start_date = :start_date
    @end_date = :end_date
  end
end
