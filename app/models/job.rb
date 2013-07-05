class Job < ActiveRecord::Base
  attr_accessible :name, :description, :email, :company, :source_url
  has_many :job_tags
  has_many :tags, :through => :job_tags
  has_many :job_lists
  has_many :lists, :through => :job_lists
end
