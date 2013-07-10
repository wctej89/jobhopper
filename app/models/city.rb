class City < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude
  has_many :jobs
end
