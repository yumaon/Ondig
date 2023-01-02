class Artist::LiveSchedulesController < ApplicationController
  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @live_schedules = @artist_user.live_schedules

    @current_ArtistUser_join = Join.where(artist_user_id: current_artist_user.id)
    @ArtistUser_join = Join.where(artist_user_id: @artist_user.id)
    unless @artist_user.id == current_artist_user.id
      @current_ArtistUser_join.each do |current_artist|
        @ArtistUser_join.each do |other_artist|
          if current_artist.room_id == other_artist.room_id then
            @isRoom = true
            @roomId = current_artist.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @join = Join.new
      end
    end

  end

  def new
    @live_schedule = LiveSchedule.new
  end

  def create
    live_schedule = current_artist_user.live_schedules.new(live_schedule_params)
    live_schedule.save
    redirect_to artist_artist_user_live_schedules_path
  end

  def edit
    @live_schedule = LiveSchedule.find(params[:id])
  end

  def update
    live_schedule = LiveSchedule.find(params[:id])
    live_schedule.update(live_schedule_params)
    redirect_to artist_artist_user_live_schedules_path
  end

  def destroy
    live_schedule = LiveSchedule.find(params[:id])
    live_schedule.destroy
    redirect_to artist_artist_user_live_schedules_path
  end

  private

  def live_schedule_params
    params.require(:live_schedule).permit(:artist_user_id, :name, :schedule_date, :price, :location)
  end
end
