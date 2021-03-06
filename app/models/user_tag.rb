class UserTag < ActiveRecord::Base
  attr_accessible :user_id, :tag_id
  belongs_to :user
  belongs_to :tag

  validates_uniqueness_of :user_id, :scope => :tag_id
end
