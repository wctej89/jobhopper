class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :tags
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates_email_format_of :email

  before_save :downcase_email

  def self.from_omniauth(auth_hash)
    where(auth_hash.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth_hash.provider
      user.uid = auth_hash.uid
      user.email = auth_hash.info.email
      user.name = auth_hash.info.name
      # TODO hack PLEASE FIX THIS
      user.password = "blank_string"
      user.password_confirmation = "blank_string"
    end
  end

private

  def downcase_email
    self.email.downcase!
  end
end
