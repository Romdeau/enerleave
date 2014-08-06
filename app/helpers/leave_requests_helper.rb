module LeaveRequestsHelper
  def format_leave_hours(leave_request)
    if leave_request.part_days.count > 0
      part_counter = 0
      leave_days_counter = (leave_request.start_date.business_days_until(leave_request.end_date) + 1)
      leave_request.part_days.each do |days|
        leave_days_counter -= 1
        part_counter += days.part_length
      end
      ((leave_days_counter * 7.6) + part_counter).round(2)
    else
      ((leave_request.start_date.business_days_until(leave_request.end_date) + 1)*7.6).round(2)
    end
  end
end
