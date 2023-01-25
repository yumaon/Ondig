class LiveSchedule < ApplicationRecord
  belongs_to :artist_user

  validates :name, presence: true
  validates :schedule_date, presence: true
  validates :price, presence: true
  validates :location, presence: true
end
