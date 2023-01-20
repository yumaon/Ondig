class Relationship < ApplicationRecord
  belongs_to :artist_follower, class_name: "ArtistUser", optional: true
  belongs_to :artist_followed, class_name: "ArtistUser", optional: true
  belongs_to :public_follower, class_name: "PublicUser", optional: true
  belongs_to :public_followed, class_name: "PublicUser", optional: true

  # フォローしている、退会していないユーザーのみを取り出す
  scope :active_artist_followed, -> { where(artist_followed_id: ArtistUser.active) }
  scope :active_public_followed, -> { where(public_followed_id: PublicUser.active) }

  # フォロワーの、退会していないユーザーのみを取り出す
  scope :active_artist_follower, -> { where(artist_follower_id: ArtistUser.active) }
  scope :active_public_follower, -> { where(public_follower_id: PublicUser.active) }

  # フォローしている、退会していないArtist会員と一般会員の数の合計値をだすメソッド
  def self.following_count
    active_artist_followed.count + active_public_followed.count
  end

  # フォローされている、退会していないArtist会員と一般会員の数の合計値を出すメソッド
  def self.follower_count
    active_artist_follower.count + active_public_follower.count
  end
end
