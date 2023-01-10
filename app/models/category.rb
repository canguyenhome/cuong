class Category < ApplicationRecord
    validates :name, presence: true
    has_many :hierarchies
end
