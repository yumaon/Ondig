class Topic < ApplicationRecord
  belongs_to :artist_user
  has_many :topic_comments, dependent: :destroy

  has_one_attached :topic_image
end
