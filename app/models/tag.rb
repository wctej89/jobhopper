class Tag < ActiveRecord::Base
  attr_accessible :name, :user_id, :job_id
  belongs_to :user
  belongs_to :job
end
