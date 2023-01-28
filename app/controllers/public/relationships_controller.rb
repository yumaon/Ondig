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

  def followings
    @public_user = PublicUser.find(params[:public_user_id])
    @followings = @public_user.public_relationships.page(params[:page]).per(9)
  end

  def followers
    @public_user = PublicUser.find(params[:public_user_id])
    @followers = @public_user.public_reverse_of_relationships.page(params[:page]).per(9)
  end
end
