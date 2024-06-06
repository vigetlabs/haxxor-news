class Article < ApplicationRecord
    validates :title, presence:true
    validates :link, presence: true
end
