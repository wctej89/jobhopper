class User < ActiveRecord::Base
  include Search
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :user_tags
  has_many :tags, :through => :user_tags
  has_one :list
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates_email_format_of :email

  before_save :downcase_email
  after_create :create_list

  def self.from_omniauth(auth_hash)
    where(auth_hash.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth_hash.provider
      user.uid = auth_hash.uid
      user.email = auth_hash.info.email
      user.name = auth_hash.info.name
      user.bio = auth_hash.info.bio
      # TODO hack PLEASE FIX THIS
      user.password = "blank_string"
      user.password_confirmation = "blank_string"
      user.build_skills(auth_hash["extra"]["raw_info"]["skills"]["values"])
    end
  end

  def build_skills(skills)
    skills.each do |skill|
      tag = Tag.find_or_create_by_name(skill["skill"]["name"].downcase)
      self.tags << tag
    end
  end

  def feed(location)
    tags = self.tags
    jobs_array = []
    tags.each {|job| jobs_array << job }
    #sort by distance
  end

private

  def create_list
    List.create(:user_id => self.id)
  end

  def downcase_email
    self.email.downcase!
  end
end
