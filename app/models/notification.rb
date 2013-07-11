class Notification < ActiveRecord::Base
  attr_accessible :user_id, :subject, :job_id
  belongs_to :user
  validates :user_id, :presence => true
  validates_uniqueness_of :subject, :scope => :user_id

  after_create :send_email

  private

  def send_email
    NotificationMailer.notification_email(self).deliver
  end
end
