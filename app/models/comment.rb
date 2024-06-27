class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  validates :text, presence: true
  has_many :votes, as: :votable

  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  scope :without_parent, -> { where(parent_id: nil) }
end
