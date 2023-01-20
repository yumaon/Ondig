class Public::ArtistUsersController < ApplicationController
  # アーティスト一覧画面
  def index
    @genres = Genre.all
    @public_user = current_public_user
    @search_params = artist_user_search_params

    # サイドバーのジャンル検索ボタンを押された時の処理
    if params[:name].present?
      # 指定されたジャンルに紐づいている、退会していないArtistUserを取得
      @artist_users = Genre.find(params[:name]).artist_users.active
    else
      # 退会していないArtistUserを取得
      @artist_users = ArtistUser.active
    end
  end

   # Artist検索アクション
  def search
    @public_user = current_public_user
    @genres = Genre.all
    @search_params = artist_user_search_params
    @artist_users = ArtistUser.active.search(@search_params).includes(:genre)
    render "index"
  end

  private

  def artist_user_search_params
    params.fetch(:search, {}).permit(:artist_name, :genre_id, :activity_location)
  end
end
