class Notification < ActiveRecord::Base
  attr_accessible :user_id, :subject, :job_id
  belongs_to :user
  validates :user_id, :presence => true
  validates_uniqueness_of :subject, :scope => :user_id

  #TODO fix background workers
  # after_create :ping_twilio
  # after_create :send_email

  private

  # def ping_twilio
  #   TwilioWorker.perform_async(self)
  # end

  def send_email
    NotificationMailer.notification_email(self).deliver
  end
end
