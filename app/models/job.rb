class Job < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  attr_accessible :name, :description, :email, :company, :source_url
  has_many :job_tags, :dependent => :destroy
  has_many :tags, :through => :job_tags
  has_many :job_lists, :dependent => :destroy
  has_many :lists, :through => :job_lists

  # after_create :tag_job still running into that redis issue


  def has_coordinates
    return true if !(self.lat.nil? && self.lng.nil?)
  end


  private 

  def tag_job
    TagWorker.perform_async(self)
  end
end
