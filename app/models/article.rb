# Each article has a title and a link, both of which are required fields.
# Will eventually add an author, score, and number-of-comments attributes.
#
# Validations:
# - title: must be present
# - link: must be present

class Article < ApplicationRecord
  validates :title, presence: true
  validates :link, presence: true
end
