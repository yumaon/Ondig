class Public::ArtistUsersController < ApplicationController
  def index
    @genres = Genre.all
    @public_user = current_public_user
    @search_params = artist_user_search_params

    # サイドバーのジャンル検索ボタンを押された時の処理
    if params[:name].present?
      @artist_users = Genre.find(params[:name]).artist_users
    else
      @artist_users = ArtistUser.all
    end
  end

   # Artist検索アクション
  def search
    @public_user = current_public_user
    @genres = Genre.all
    @search_params = artist_user_search_params
    @artist_users = ArtistUser.search(@search_params).includes(:genre)
    render "index"
  end

  private

  def artist_user_search_params
    params.fetch(:search, {}).permit(:artist_name, :genre_id, :activity_location)
  end
end
