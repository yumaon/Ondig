class Topic < ApplicationRecord
  belongs_to :artist_user
  has_many :topic_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :topic_image

  def public_user_favorited_by?(public_user)
    favorites.exists?(public_user_id: public_user.id)
  end

end
