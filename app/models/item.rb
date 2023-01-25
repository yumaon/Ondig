class Item < ApplicationRecord
  belongs_to :artist_user

  has_one_attached :item_image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :item_image, presence: true
end
