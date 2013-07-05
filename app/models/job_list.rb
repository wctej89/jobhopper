class JobList < ActiveRecord::Base
  attr_accessible :job_id, :list_id, :status
  belongs_to :job
  belongs_to :list
end
