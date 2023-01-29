class Public::RelationshipsController < ApplicationController

  # followをするとき
  def artist_follow
    current_public_user.follow_an_artist(params[:artist_user_id])
    redirect_to request.referer
  end

  def public_follow
    current_public_user.follow_an_public(params[:public_user_id])
    redirect_to request.referer
  end

  # followを外すとき
  def artist_unfollow
    current_public_user.unfollow_an_artist(params[:artist_user_id])
    redirect_to request.referer
  end

  def public_unfollow
    current_public_user.unfollow_an_public(params[:public_user_id])
    redirect_to request.referer
  end

  # follow一覧
  def followings
    @public_user = PublicUser.find(params[:public_user_id])

    # 取得した一般会員のフォロー中の退会していないユーザーを取得
    @followings = @public_user.active_followings.order(created_at: :desc).page(params[:page]).per(9)
  end

  # follower一覧
  def followers
    @public_user = PublicUser.find(params[:public_user_id])

    # 取得した一般会員のフォロワーの退会していないユーザーを取得
    @followers = @public_user.active_followers.order(created_at: :desc).page(params[:page]).per(9)
  end
end
