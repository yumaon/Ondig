class Artist::RelationshipsController < ApplicationController

  # followをするとき
  def artist_follow
    current_artist_user.follow_an_artist(params[:artist_user_id])
    redirect_to request.referer
  end

  def public_follow
    current_artist_user.follow_an_public(params[:public_user_id])
    redirect_to request.referer
  end

  # followを外すとき
  def artist_unfollow
    current_artist_user.unfollow_an_artist(params[:artist_user_id])
    redirect_to request.referer
  end

  def public_unfollow
    current_artist_user.unfollow_an_public(params[:public_user_id])
    redirect_to request.referer
  end

  # follow一覧
  def followings
    @artist_user = ArtistUser.find(params[:artist_user_id])

    # 取得したArtist会員のフォロー中の退会していないユーザーを取得
    @followings = @artist_user.active_followings.order(created_at: :desc).page(params[:page]).per(9)
  end

  # follower一覧
  def followers
    @artist_user = ArtistUser.find(params[:artist_user_id])

    # 取得したArtist会員のフォロワーの退会していないユーザーを取得
    @followers = @artist_user.active_followers.order(created_at: :desc).page(params[:page]).per(9)
  end
end
