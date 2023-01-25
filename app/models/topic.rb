class Topic < ApplicationRecord
  belongs_to :artist_user
  has_many :topic_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :topic_tags, dependent: :destroy

  # throughオプションによりtopic_tagsテーブルを通してtagsテーブルとの関連付け
  has_many :tags, through: :topic_tags

  has_one_attached :topic_image

  validates :body, presence: true

  # 退会していないユーザーだけのトピックスを表示させるための記述
  scope :active_topics, -> { where(artist_user_id: ArtistUser.active) }
  # 退会しているユーザーだけのトピックスを表示させるための記述
  scope :not_active_topics, -> { where(artist_user_id: ArtistUser.deleted) }

  def save_tag(sent_tags)
    # タグが存在していれば、タグ名を配列としてすべて取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?

    # 現在取得したタグから送られてきたタグを除いてold_tagとする
    old_tags = current_tags - sent_tags

    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(name: old_tag)
    end

    # 新しいタグを保存する
    new_tags.each do |new_tag|
      new_topic_tag = Tag.find_or_create_by(name: new_tag)
      self.tags << new_topic_tag
    end
  end

  # トピックスのキーワード検索
  def self.search(keyword)
    Topic.where(["body LIKE?", "%#{keyword}"])
  end

  def public_user_favorited_by?(public_user)
    favorites.exists?(public_user_id: public_user.id)
  end

  def artist_user_favorited_by?(artist_user)
    favorites.exists?(artist_user_id: artist_user.id)
  end

end
