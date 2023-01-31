class Admin::ArtistUsersController < ApplicationController
  before_action :authenticate_admin!
  # ArtistUser一覧
  def index
    # ジャンルを指定してindexページを表示させる
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @artist_users = @genre.artist_users.page(params[:page]).per(10)
      @search_params = artist_user_search_params

    # ジャンル設定をしていないArtistUserを指定しindexページを表示させる
    elsif params[:genre_nil].present?
      @artist_users = ArtistUser.where(genre_id: nil).all.page(params[:page]).per(10)
      @search_display = "未設定"
      @search_params = artist_user_search_params

    # 退会しているArtistUserを指定し、indexページを表示させる
    elsif params[:no_active].present?
      @artist_users = ArtistUser.deleted.page(params[:page]).per(10)
      @search_display = "退会済みのアカウント"
      @search_params = artist_user_search_params

    # ジャンルは指定せず、indexページを表示させる(全てのArtistUser)
    else
      @artist_users = ArtistUser.all.page(params[:page]).per(10)
      @search_params = artist_user_search_params
    end
  end

  # ArtistUser検索アクション
  def search
    @search_params = artist_user_search_params
    @artist_users = ArtistUser.search(@search_params).includes(:genre).page(params[:page]).per(10)
    render "index"
  end

  # ArtistUser詳細画面
  def show
    @artist_user = ArtistUser.find(params[:id])
  end

  # ArtistUser情報編集
  def edit
    @artist_user = ArtistUser.find(params[:id])
  end

  # ArtistUser情報更新
  def update
    @artist_user = ArtistUser.find(params[:id])
    @artist_user.update(artist_user_params)
    redirect_to admin_artist_user_path
  end

  # ゲストユーザーを削除
  def guest_delete
    artist_user = ArtistUser.find(params[:id])
    artist_user.destroy
    redirect_to admin_artist_users_path
  end

  private

  def artist_user_params
    params.require(:artist_user).permit(:artist_name, :rep_name, :rep_name_kana, :genre_id, :activity_location, :email, :youtube_url, :is_deleted)
  end

  def artist_user_search_params
    params.fetch(:search, {}).permit(:artist_name, :genre_id, :activity_location)
  end
end
