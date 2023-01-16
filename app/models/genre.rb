class Genre < ApplicationRecord
  has_many :artist_users
end
