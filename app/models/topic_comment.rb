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

  # 退会していないArtist会員、一般会員のコメントを取得するメソッド
  def self.active_comments
    active_comment_id_box = []
    # 退会していないArtist会員のコメントを取得し、そのidをactive_comment_id_boxに格納
    self.artist_active_comments.each do |artist_comment|
      active_comment_id_box << artist_comment.id
    end
    # 退会していない一般会員のコメントを取得し、そのidをactive_comment_id_boxに格納
    self.public_active_comments.each do |public_comment|
      active_comment_id_box << public_comment.id
    end
    # 上記で取得したidのコメントを取得
    self.where(id: active_comment_id_box)
  end
end
