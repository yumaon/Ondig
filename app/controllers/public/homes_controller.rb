class Public::HomesController < ApplicationController
  def top
    # 最新のArtistUserの情報を３件取得
    @artist_users = ArtistUser.active.order(created_at: :desc).limit(3)
    # 最新のトピックスの情報を３件取得
    @topics = Topic.active_topics.order(created_at: :desc).limit(3)
  end

  def about
  end
end
