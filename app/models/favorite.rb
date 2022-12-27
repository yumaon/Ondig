class Favorite < ApplicationRecord
  belongs_to :public_user, optional: true
  belongs_to :artist_user, optional: true
  belongs_to :topic
end
