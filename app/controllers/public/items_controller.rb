class Public::ItemsController < ApplicationController
  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @items = @artist_user.items
  end
end
