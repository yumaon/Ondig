class Public::ProfileTopicsController < ApplicationController
  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @topics = @artist_user.topics
  end
end
