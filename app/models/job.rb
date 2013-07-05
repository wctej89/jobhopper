class Job < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  attr_accessible :name, :description, :email, :company, :source_url
  has_many :job_tags
  has_many :tags, :through => :job_tags


  def has_coordinates
    return true if !(self.lat.nil? && self.lng.nil?)
  end
end
