class Notification < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true
  validates_uniqueness_of :subject, :scope => :user_id

  after_create :ping_twilio
  after_create :send_email

  private

  def ping_twilio
    TwilioWorker.perform_async(self)
  end

  def send_email
    NotificationMailer.notification_email(self).deliver
  end
end
