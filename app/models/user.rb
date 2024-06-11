class User < ApplicationRecord
  has_secure_password
  has_many :article, foreign_key: "author_id"

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
