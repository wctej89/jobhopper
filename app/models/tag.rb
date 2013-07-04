class Tag < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user
  belongs_to :job
end
