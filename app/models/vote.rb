class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :value, inclusion: {in: [-1, 0, 1]}
  validates :user_id, uniqueness: {scope: [:votable_id, :votable_type]}
end
