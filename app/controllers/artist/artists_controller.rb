class Artist::ArtistsController < ApplicationController
  def index
    @artist_users = ArtistUser.all
  end

  def show
    @artist_user = ArtistUser.find(params[:id])
  end

  def edit
  end
end
