class Relationship < ApplicationRecord
  belongs_to :artist_follower, class_name: "ArtistUser", optional: true
  belongs_to :artist_followed, class_name: "ArtistUser", optional: true
  belongs_to :public_follower, class_name: "PublicUser", optional: true
  belongs_to :public_followed, class_name: "PublicUser", optional: true
end
