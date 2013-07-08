class Job < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :name, :description, :email, :company, :source_url
  has_many :job_tags, :dependent => :destroy
  has_many :tags, :through => :job_tags
  has_many :job_lists, :dependent => :destroy
  has_many :lists, :through => :job_lists

  validates_presence_of :name, :description, :source_url
  validates_uniqueness_of :source_url

  after_create :tag_job, :notify_users

  def has_coordinates
    return true if !(self.lat.nil? && self.lng.nil?)
  end

  private 

  def tag_job
    TagWorker.perform_in(10.seconds, self.id)
  end

  def notify_users
    NotificationWorker.perform_in(30.seconds, self.id)
  end
end
