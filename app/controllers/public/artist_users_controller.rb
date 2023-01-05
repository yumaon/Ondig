class Public::ArtistUsersController < ApplicationController
  def index
    @artist_users = ArtistUser.all
  end

   # Artist検索アクション
  def search
    @artist_users = ArtistUser.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end
end
