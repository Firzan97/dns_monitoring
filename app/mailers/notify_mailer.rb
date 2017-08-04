class NotifyMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
  def send_notification(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
