class JobTag < ActiveRecord::Base
  attr_accessible :tag_id
  belongs_to :job
  belongs_to :tag
end
