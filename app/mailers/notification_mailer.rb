class NotificationMailer < ActionMailer::Base
  default from: 'from@example.com'
  def notification_email(notification)
    @user = notification.user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "A new Job from Jobhopper! #{notification.subject}")
  end
end
