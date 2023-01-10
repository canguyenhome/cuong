class Repository < ApplicationRecord
    validates :name, presence: true
    validates :owner, presence: true
end
