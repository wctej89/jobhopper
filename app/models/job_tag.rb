class JobTag < ActiveRecord::Base
  attr_accessible :tag_id
  belongs_to :job
  belongs_to :tag

  validates_uniqueness_of :job_id, :scope => :tag_id
end
