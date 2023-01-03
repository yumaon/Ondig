class Public::RoomsController < ApplicationController
  def create
    @room = Room.create
    @join1 = Join.create(:room_id => @room.id, :public_user_id => current_public_user.id)
    @join2 = Join.create(params.require(:join).permit(:public_user_id, :artist_user_id, :room_id).merge(:room_id => @room.id))
    redirect_to rooms_public_public_users_path(@room.id)
  end

  def index
    @public_user = PublicUser.find(params[:public_user_id])
    my_room_id = []
    @public_user.joins.each do |join|
      my_room_id << join.room.id
    end
    @another_joins = Join.where(room_id: my_room_id).order(created_at: :desc)
  end

  def show
    @public_user = current_public_user
    @room = Room.find(params[:id])
    if Join.where(public_user_id: current_public_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @joins = @room.joins
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
