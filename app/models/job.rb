class Job < ActiveRecord::Base
  # include Tire::Model::Search
  # include Tire::Model::Callbacks

  attr_accessible :name, :description, :email, :company, :source_url, :lat, :lng, :city_id
  has_many :job_tags, :dependent => :destroy
  has_many :tags, :through => :job_tags
  has_many :job_lists, :dependent => :destroy
  has_many :lists, :through => :job_lists
  belongs_to :city

  validates_presence_of :name, :description, :source_url
  validates_uniqueness_of :source_url

  # after_create :tag_job, :notify_users
  # TODO get_job_location here. Fix background worker

  def self.search(params)
    tire.search(load: true) do
      query { string params["search"], default_operator: "AND" } if params["search"].present?
      filter :range, created_at: { gte: Time.zone.now - 24.hours }
    end
  end

  def has_coordinates
    return true if !(self.lat.nil? || self.lng.nil?)
    false
  end

  def has_city?
    return true if self.city != nil
    false
  end

  private 

  def tag_job
    TagWorker.perform_in(10.seconds, self.id)
  end

  def notify_users
    NotificationWorker.perform_in(30.seconds, self.id)
  end

  # def get_job_location
  #   LocationWorker.perform_in(10.seconds, self.id)
  # end
end
