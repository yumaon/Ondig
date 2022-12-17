class Genre < ApplicationRecord
  has_many :artist_users, dependent: :destroy
end
