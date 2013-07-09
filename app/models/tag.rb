 class Tag < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  attr_accessible :name, :tag_type

  has_many :user_tags
  has_many :users, :through => :user_tags
  has_many :job_tags
  has_many :jobs, :through => :job_tags
  validates :name, :uniqueness => true
  validates :name, presence: true

  def self.search(params)
    tire.search(load: true) do
      query { string params["search"], default_operator: "AND" } if params["search"].present?
    end
  end

  def self.location_create(location_string)
    locations = []
    Tag.where('tag_type = ?', 'LocationTag').each do |tag|
      if location_string.downcase.scan(tag.name) != []
        locations << tag
    else
        Tag.create(:name => location_string.downcase, :tag_type => 'LocationTag')
      end
    end
  end

  def is_location?
    self.tag_type == 'LocationTag'
  end
end
