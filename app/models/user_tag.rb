class UserTag < ActiveRecord::Base
  attr_accessible :user_id, :tag_id
  belongs_to :user
  belongs_to :tag
end
