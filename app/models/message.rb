class Message < ApplicationRecord
  belongs_to :artist_user, optional: true
  belongs_to :public_user, optional: true
  belongs_to :room

  validates :content, presence: true
end
