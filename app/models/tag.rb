class Tag < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  attr_accessible :name, :tag_type
  has_many :user_tags
  has_many :users, :through => :user_tags
  has_many :job_tags
  has_many :jobs, :through => :job_tags
  # validates :name, uniqueness: true
  validates :name, presence: true

  def self.search(params)
    tire.search(load: true) do
      query { string params, default_operator: "AND" } if params.present?
    end
  end
end
