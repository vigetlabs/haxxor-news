class User < ApplicationRecord
  has_secure_password
  has_many :articles
  has_many :comments
  has_many :votes

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address"}
end
