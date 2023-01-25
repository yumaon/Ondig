class TopicComment < ApplicationRecord
  belongs_to :topic
  belongs_to :public_user, optional: true
  belongs_to :artist_user, optional: true

  validates :comment, presence: true

  # 退会していないユーザーのコメントを取得するための記述
  scope :artist_active_comments, -> { where(artist_user_id: ArtistUser.active) }
  scope :public_active_comments, -> { where(public_user_id: PublicUser.active) }

  # 退会していないユーザーのコメント数の合計値を出すためのメソッド
  def self.comments_count
    artist_active_comments.count + public_active_comments.count
  end
end
