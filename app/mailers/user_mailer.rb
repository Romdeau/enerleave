class UserMailer < ActionMailer::Base
  default from: "EnerLeave@eneraque.com"

  def welcome_email(user)
    @user = user
    @url = 'http://enerleave.eneraque.com/login'
    mail(to: @user.email, subject: 'Welcome to EnerLeave: Leave Tracking')
end
