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
    @followings = @artist_user.artist_relationships
  end

  # follower一覧
  def followers
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @followers = @artist_user.artist_reverse_of_relationships
  end
end
