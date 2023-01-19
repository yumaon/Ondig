class Tag < ApplicationRecord
  has_many :topic_tags, dependent: :destroy, foreign_key: 'tag_id'

  # throughオプションにより、topic_tagsを通してtopicsテーブルと関連付け
  has_many :topics, through: :topic_tags

  validates :name, uniqueness: true, presence: true

  # 退会していないユーザーのトピックスに紐づくタグのみを取得するためのメソッド
  def self.active_tags
    active_tag_id_box = []
    # すべての退会していないユーザーのトピックスを取得し展開
    topics = Topic.active_topics
    topics.each do |topic|
      # トピックスに紐づいているタグを展開し、そのtag.idをactive_tag_id_boxに格納する
      topic.tags.each do |tag|
        active_tag_id_box << tag.id
      end
    end
    # タグモデルから、上記で取得したtag.idで検索し取得する
    Tag.where(id: active_tag_id_box)
  end

end
