class User < ActiveRecord::Base
  has_many :articles

  before_save { self.email = email.downcase }

  has_secure_password

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true,
                    confirmation: true,
                    uniqueness: { case_sensitive: false },
                    format:  { with: VALID_EMAIL_REGEX, message: "Must be an email address" }
  # validates :email_confirmation, presence: true

  validates :password, confirmation: true, if: :new_record?

end
