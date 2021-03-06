class User < ActiveRecord::Base
  include Feed

  attr_accessible :name, :email, :password, :password_confirmation, :lat, :lng
  # has_secure_password 
  has_many :user_tags, :dependent => :destroy
  has_many :tags, :through => :user_tags
  has_one :list, :dependent => :destroy
  has_many :jobs, :through => :list
  has_many :notifications, :dependent => :destroy
  
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
      user.bio = auth_hash.extra.raw_info.summary
      user.location = auth_hash.info.location
      user.build_skills(auth_hash["extra"]["raw_info"]["skills"]["values"])
    end
  end

  def skills
    skills = []
    self.tags.each {|tag| skills << tag if tag.tag_type != 'LocationTag' }
    skills
  end


  def locations
    locations = []
    self.tags.each {|tag| locations << tag if tag.tag_type == 'LocationTag' }
    locations
  end

  def build_skills(skills)
    skills.each do |skill|
      tag = Tag.find_or_create_by_name(skill["skill"]["name"].downcase)
      self.tags << tag
    end
  end

  def feed(location_array, page)
    # TODO begin rescue here
    final_result = remove_queued_jobs(sort_by_radius(Job.includes(:city).joins(:tags => :users).where("users.id =?", self.id).uniq, [self.lat, self.lng]))
    complete_values = remove_queued_jobs(final_result[:location_available].values + final_result[:location_unavailable].values)
    sleep(1)
    result = {}
    final_result_count = final_result[:location_available].count + final_result[:location_unavailable].count
    result[:total] = final_result_count
    start_index = (page-1)*10
    result[:total_pages] = final_result_count/10
    result[:results] = complete_values[start_index...start_index+10]
    result[:miles] = final_result[:location_available].keys
    result
  end

  def remove_queued_jobs(job_array)
    job_array.each do |job|
      if self.jobs.include?(job)
        puts job
        job_array.delete(job)
      end
    end
    job_array
  end

  def add_location!(params)
    self.update_attributes(:lat => params["lat"], :lng => params["lng"])
  end

  private

  def create_list
    List.create(:user_id => self.id)
  end

  def downcase_email
    self.email.downcase!
  end
end
