class Public::FavoritesController < ApplicationController

  def index
    @public_user = current_public_user
    @favorites = @public_user.favorites
  end

  def create
    topic = Topic.find(params[:topic_id])
    favorite = current_public_user.favorites.new(topic_id: topic.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    topic = Topic.find(params[:topic_id])
    favorite = current_public_user.favorites.find_by(topic_id: topic.id)
    favorite.destroy
    redirect_to request.referer
  end

end
