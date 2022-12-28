class Public::FavoritesController < ApplicationController

  def index
    @public_user = PublicUser.find(params[:public_user_id])
    @favorites = @public_user.favorites
  end

  def create
    topic = Topic.find(params[:topic_id])
    favorite = current_public_user.favorites.new(topic_id: topic.id)
    favorite.save
    redirect_to public_topic_path(topic)
  end

  def destroy
    topic = Topic.find(params[:topic_id])
    favorite = current_public_user.favorites.find_by(topic_id: topic.id)
    favorite.destroy
    redirect_to public_topic_path(topic)
  end

end
