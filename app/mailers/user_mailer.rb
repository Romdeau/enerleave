class UserMailer < ActionMailer::Base
  default from: "EnerLeave@eneraque.com"

  def welcome_email(user)
    @user = user
    @url = 'http://enerleave.eneraque.com/login'
    mail(to: @user.email, subject: 'Welcome to EnerLeave: Leave Tracking')
  end

  def leave_request(user)
    @user = user
    @url = 'http://enerleave.eneraque.com/leave_requests/approvals'
    mail(to: @user.manager_email, subject: 'New EnerLeave Leave Request')
  end

  def toil_request(user)
    @user = user
    @url = "http://enerleave.eneraque.com/users/#{@user.id}/toil"
    mail(to: 'enerleaveadmins@eneraque.com', subject: 'New EnerLeave Toil Request')
  end

  def assign_manager(user)
    @user = user
    @url = "http://enerleave.eneraque.com/users/#{@user.id}/"
    mail(to: @user.manager_email, subject: "You have been assigned as the manager of #{@user.email}")
  end

  def leave_approved(user)
    @user = user
    @url = "http://enerleave.eneraque.com/"
    mail(to: @user.email, cc: "laura.pringle@eneraque.com", subject: "Your leave request was approved")
  end

  def toil_approved(user)
    @user = user
    @url = "http://enerleave.eneraque.com/users/#{@user.id}/toil"
    mail(to: @user.email, cc: "laura.pringle@eneraque.com", subject: 'Your Toil Request was approved')
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

  def reject_leave(user, leave)
    @user = user
    @leave = leave
    mail(to: @user.email, cc: @user.manager_email, subject: "Your leave request: #{@leave.start_date}; #{@leave.comment} has been rejected") 
  end
end
