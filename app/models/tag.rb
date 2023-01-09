class Tag < ApplicationRecord
  has_many :topic_tags, dependent: :destroy, foreign_key: 'tag_id'
  
  # throughオプションにより、topic_tagsを通してtopicsテーブルと関連付け
  has_many :topics, through: :topic_tags

  validates :name, uniqueness: true, presence: true
end
