class Topic < ApplicationRecord
  belongs_to :artist_user

  has_one_attached :topic_image
end
