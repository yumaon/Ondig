class Public::HomesController < ApplicationController
  def top
    @artist_users = ArtistUser.active.order(created_at: :desc).limit(3)
  end

  def about
  end
end
