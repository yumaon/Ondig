class Public::HomesController < ApplicationController
  def top
    # 最新のArtistUserの情報を３件取得
    @artist_users = ArtistUser.active.order(created_at: :desc).limit(3)

    # フォロワーが多いArtistUserを３件取得
    @popular_artist_users = ArtistUser.active.sort {|a, b| b.active_followers.count.to_i <=> a.active_followers.count.to_i}.slice(0..2)

    # 最新のトピックスの情報を３件取得
    @topics = Topic.active_topics.order(created_at: :desc).limit(3)

    # いいねの数が多いトピックスを3件取得
    @popular_topics = Topic.active_topics.sort {|a, b| b.favorites.count.to_i <=> a.favorites.count.to_i}.slice(0..2)
  end

  def about
  end
end
