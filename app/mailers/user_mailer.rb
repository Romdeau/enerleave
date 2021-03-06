class UserMailer < ActionMailer::Base
  default from: "EnerLeave@eneraque.com"

  def welcome_email(user)
    @user = user
    @url = 'http://enerleave.eneraque.com/login'
    mail(to: @user.email, subject: 'Welcome to EnerLeave: Leave Tracking')
  end

  def leave_request(user, leave_request)
    @leave_request = leave_request
    @user = user
    @url = 'http://enerleave.eneraque.com/leave_requests/approvals'
    mail(to: @user.manager_email, cc: "laura.pringle@eneraque.com", subject: 'New EnerLeave Leave Request')
  end

  def toil_request(user)
    @user = user
    @url = "http://enerleave.eneraque.com/users/#{@user.id}/toil"
    mail(to: @user.email, cc: "#{@user.manager_email}, laura.pringle@eneraque.com", subject: 'New EnerLeave Toil Request')
  end

  def assign_manager(user)
    @user = user
    @url = "http://enerleave.eneraque.com/users/#{@user.id}/"
    mail(to: @user.manager_email, subject: "You have been assigned as the manager of #{@user.email}")
  end

  def leave_approved(user, approving_user, request)
    @user = user
    @approving_user = approving_user
    @url = "http://enerleave.eneraque.com/"
    @leave = request
    mail(to: @user.email, cc: "laura.pringle@eneraque.com", subject: "Your leave request was approved")
  end

  def toil_approved(user, approving_user, request)
    @user = user
    @approving_user = approving_user
    @url = "http://enerleave.eneraque.com/users/#{@user.id}/toil"
    @toil = request
    mail(to: @user.email, cc: "laura.pringle@eneraque.com", subject: 'Your Toil Request was approved')
  end

  def manager_toil_approved(user, approving_user, request)
    @user = user
    @approving_user = approving_user
    @url = "http://enerleave.eneraque.com/users/#{@user.id}/toil"
    @toil = request
    mail(to: @user.email, cc: "#{@user.manager_email}, laura.pringle@eneraque.com", subject: 'Your Toil Request was approved by a Manager')
  end

  def spend_toil_approved(user, approving_user, request)
    @user = user
    @approving_user = approving_user
    @url = "http://enerleave.eneraque.com/users/#{@user.id}/toil"
    @toil = request
    mail(to: @user.email, cc: "laura.pringle@eneraque.com", subject: 'Your Toil Request was approved')
  end

  def manager_spend_toil_approved(user, approving_user, request)
    @user = user
    @approving_user = approving_user
    @url = "http://enerleave.eneraque.com/users/#{@user.id}/toil"
    @toil = request
    mail(to: @user.email, cc: "#{@user.manager_email}, laura.pringle@eneraque.com", subject: 'Your Toil Request was approved by a Manager')
  end

  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    mail(:to => user.email, :subject => "Your password has been reset")
  end

  def notify_not_manager(user)
    @user = user
    @url = "http://enerleave.eneraque.com/users/#{user}/"
    mail(to: "thomas.taege@eneraque.com", cc: "laura.pringle@eneraque.com", subject: "User has assigned a manager who is not a manager")
  end

  def reject_leave(rejecting_user, leave, comment)
    @leave = leave
    @user = @leave.user
    @rejecting_user = rejecting_user
    @comment = comment
    mail(to: @user.email, cc: "#{@user.manager_email}, laura.pringle@eneraque.com", subject: "Your leave request: #{@leave.start_date}; #{@leave.comment} has been rejected")
  end

  def reject_toil(user, toil, comment, rejecting_user)
    @user = user
    @toil = toil
    @comment = comment
    @rejecting_user = rejecting_user
    mail(to: @user.email, cc: "#{@user.manager_email}, laura.pringle@eneraque.com", subject: "Your leave request: #{@toil.date_accrued}; has been rejected")
  end

  def reject_toil_spend(user, toil_spend, comment, rejecting_user)
    @user = user
    @toil = toil_spend
    @comment = comment
    @rejecting_user = rejecting_user
    mail(to: @user.email, cc: "#{@user.manager_email}, laura.pringle@eneraque.com", subject: "Your leave request: #{@toil.leave_date}; has been rejected")
  end

  def lodge_travel_request(user, travel_request)
    @user = user
    @travel_request = travel_request
    @url = "http://enerleave.eneraque.com/travel_requests/#{travel_request.id}"
    mail(to: "travel@eneraque.com, #{@user.manager_email}", cc: "#{@user.email}", subject: "#{@user.email} has lodged a new travel request")
  end

  def approve_travel_request(user, travel_request)
    @user = travel_request.user
    @travel_request = travel_request
    @approver_email = user.email
    @url = "http://enerleave.eneraque.com/travel_requests/#{travel_request.id}"
    mail(to: "#{@user.email}, travel@eneraque.com", cc: "#{@user.manager_email}", subject: "Travel Request from #{@user.email} has been approved")
  end

  def booked_travel_request(user, travel_request)
    @user = travel_request.user
    @travel_request = travel_request
    @approver_email = user.email
    @url = "http://enerleave.eneraque.com/travel_requests/#{travel_request.id}"
    mail(to: "#{@user.email}", cc: "travel@eneraque.com", subject: "Travel Request from #{@user.email} has been completely booked")
  end

  def reject_travel_request(travel_request, manager, comment)
    @user = travel_request.user
    @manager = manager
    @comment = comment
    @url = "http://enerleave.eneraque.com/travel_requests/#{travel_request.id}"
    mail(to: "#{@user.email}", cc: "travel@eneraque.com, #{manager.email}", subject: "Travel Request from #{@user.email} has been rejected by a manager.")
  end

end
