class Public::ArtistUsersController < ApplicationController
  def index
    @artist_users = ArtistUser.all
  end
end
