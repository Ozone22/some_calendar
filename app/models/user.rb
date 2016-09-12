class User < ActiveRecord::Base

  attr_accessor :origin_remember_token

  before_save { self.email.downcase! }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  PASSWORD_REGEX = /(?=^.{5,}\z)(?=.*[A-Z])(?=.*\d).*\z/

  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: EMAIL_REGEX, message: I18n.t('activerecord.errors.user.attributes.email.wrong_email') }
  validates :fio, length: { maximum: 150 }
  validates :password, presence: true, length: { minimum: 6, maximum: 60 },
            format: { with: PASSWORD_REGEX, message: I18n.t('activerecord.errors.user.attributes.password.wrong_pass') }

  has_secure_password

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def remember
    self.origin_remember_token = User.new_token
    update_attribute(:remember_token, User.encrypt(origin_remember_token))
  end

  def forget
    update_attribute(:remember_token, nil)
  end

  def token_valid?(origin_remember_token)
    User.encrypt(origin_remember_token).eql? remember_token
  end

end
