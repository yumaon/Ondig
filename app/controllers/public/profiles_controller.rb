class Public::ProfilesController < ApplicationController
  def show
    @artist_user = ArtistUser.find(params[:id])
  end
end
