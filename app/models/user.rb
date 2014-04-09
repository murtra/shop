class User < ActiveRecord::Base
  has_secure_password

  PASSWORD_REGEX = /\A(?=.*\d)(?=.*[a-zA-Z]).{2,}\z/
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  validates :name, :email, presence: true

  validates :email, uniqueness: true
  #validates :email, format: { with: EMAIL_REGEX, message: "hasn't a valid format" }, unless: "email.blank?"
  validate :email, email: true

  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :password, format: { with: PASSWORD_REGEX, message: "must contain at least one digit and one character" }, unless: "password.blank?"

end
