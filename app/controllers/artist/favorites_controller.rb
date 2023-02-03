class Artist::FavoritesController < ApplicationController
  before_action :set_variables, only:[:create, :destroy]
  # いいねしたトピックス一覧
  def index
    @artist_user = current_artist_user
    favorites = Favorite.where(artist_user_id: @artist_user.id).pluck(:topic_id)
    @topics = Topic.active_topics.where(id: favorites).order(created_at: :desc).page(params[:page]).per(10)
  end

  # いいねアクション
  def create
    topic = Topic.find(params[:topic_id])
    favorite = current_artist_user.favorites.new(topic_id: topic.id)
    favorite.save
  end

  # いいねを取り消すアクション
  def destroy
    topic = Topic.find(params[:topic_id])
    favorite = current_artist_user.favorites.find_by(topic_id: topic.id)
    favorite.destroy
  end

  private

  def set_variables
    @topic = Topic.find(params[:topic_id])
    @id_name = "#topic-favorite-#{@topic.id}"
  end
end
