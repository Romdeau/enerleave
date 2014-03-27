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
    mail(to: @user.email, subject: "Your leave request was approved")
  end

  def toil_approved(user)
    @user = user
    @url = "http://enerleave.eneraque.com/users/#{@user.id}/toil"
    mail(to: @user.email, subject: 'Your Toil Request was approved')
  end
end
