class Item < ApplicationRecord
  belongs_to :artist_user

  has_one_attached :item_image
end
