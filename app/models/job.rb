class Job < ActiveRecord::Base
  attr_accessible :name, :description, :email, :company, :source_url
end
