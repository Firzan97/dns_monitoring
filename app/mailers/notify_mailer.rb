class NotifyMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
  def send_notification(ip)
    @user = ip
    @url  = 'http://example.com/login'
    mail(to: "FirzanAzrai97@gmail.com", subject: 'Welcome to My Awesome Site')
  end
end
