class Admin::ArtistUsersController < ApplicationController
  def index
    @artist_users = ArtistUser.all
  end

  def show
    @artist_user = ArtistUser.find(params[:id])
  end

  def edit
    @artist_user = ArtistUser.find(params[:id])
  end

  def update
    @artist_user = ArtistUser.find(params[:id])
    @artist_user.update(artist_user_params)
    redirect_to admin_artist_user_path
  end

  private

  def artist_user_params
    params.require(:artist_user).permit(:artist_name, :rep_name, :rep_name_kana, :genre_id, :activity_location, :email, :youtube_url, :is_deleted)
  end
end
