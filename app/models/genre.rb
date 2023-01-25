class Genre < ApplicationRecord
  has_many :artist_users

  validates :name, presence: true
end
