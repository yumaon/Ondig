class TopicComment < ApplicationRecord
  belongs_to :topic
  belongs_to :public_user, optional: true
  belongs_to :artist_user, optional: true
end
