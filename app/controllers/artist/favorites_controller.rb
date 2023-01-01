class Artist::FavoritesController < ApplicationController

  def index
    @artist_user = current_artist_user
    @favorites = @artist_user.favorites
  end

  def create
    topic = Topic.find(params[:topic_id])
    favorite = current_artist_user.favorites.new(topic_id: topic.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    topic = Topic.find(params[:topic_id])
    favorite = current_artist_user.favorites.find_by(topic_id: topic.id)
    favorite.destroy
    redirect_to request.referer
  end

end
