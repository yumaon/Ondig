class Public::LiveSchedulesController < ApplicationController
  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @live_schedules = @artist_user.live_schedules
  end
end
