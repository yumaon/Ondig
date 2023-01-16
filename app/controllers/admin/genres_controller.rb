class Admin::GenresController < ApplicationController
  # ジャンル一覧・ジャンル新規作成フォーム用アクション
  def index
    @genre = Genre.new
    @genres = Genre.all
    @genre_nil_artist_users = ArtistUser.where(genre_id: nil).all
  end

  # ジャンル新規作成アクション
  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def edit
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to admin_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
