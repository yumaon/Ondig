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
end
