class Artist::ArtistsController < ApplicationController
  def index
    @artist_users = ArtistUser.all
  end

  def show
  end

  def edit
  end
end
