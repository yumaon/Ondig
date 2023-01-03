class Artist::RoomsController < ApplicationController
  def create
    @room = Room.create
    @join1 = Join.create(:room_id => @room.id, :artist_user_id => current_artist_user.id)
    @join2 = Join.create(params.require(:join).permit(:artist_user_id, :public_user_id, :room_id).merge(:room_id => @room.id))
    redirect_to rooms_artist_artist_users_path(@room.id)
  end

  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    my_room_id = []
    @artist_user.joins.each do |join|
      my_room_id << join.room.id
    end
    @another_joins = Join.where(room_id: my_room_id).order(created_at: :desc)
  end

  def show
    @artist_user = current_artist_user
    @room = Room.find(params[:id])
    if Join.where(artist_user_id: current_artist_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @joins = @room.joins
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
