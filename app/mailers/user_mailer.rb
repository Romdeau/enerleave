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
    mail(to: enerleaveadmins@eneraque.com, subject: 'New EnerLeave Leave Request')
  end

  def toil_request(user)
    @user = user
    @url = "http://enerleave.eneraque.com/users/#{@user.id}/toil"
    mail(to: enerleaveadmins@eneraque.com, subject: 'New EnerLeave Toil Request')
  end
end
