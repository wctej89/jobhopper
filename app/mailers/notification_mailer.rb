class NotificationMailer < ActionMailer::Base

  def notification_email(notification)
    @user = notification.user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "A new Job from Jobhopper! #{notification.subject}")
  end
end
