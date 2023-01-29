class Public::RoomsController < ApplicationController
  def create
    @room = Room.create
    @join1 = Join.create(:room_id => @room.id, :public_user_id => current_public_user.id)
    @join2 = Join.create(params.require(:join).permit(:public_user_id, :artist_user_id, :room_id).merge(:room_id => @room.id))
    redirect_to rooms_public_public_users_path(@room.id)
  end

  def index
    @public_user = PublicUser.find(params[:public_user_id])
    # 取得したArtist会員の参加しているroom.idをmy_room_idに格納
    my_room_id = []
    @public_user.joins.each do |join|
      my_room_id << join.room.id
    end

    # 自分が参加している、roomのjoinテーブルを取得
    my_joins = Join.where(room_id: my_room_id)

    # 自分のidが含まれないjoinテーブルを取り出す。
    another_join_id_box = []
    my_joins.each do |join|
      if join.public_user_id.present?
        unless join.public_user_id == current_public_user.id
          another_join_id_box << join.id
        end
      elsif join.artist_user_id.present?
        another_join_id_box << join.id
      end
    end
    @another_joins = Join.where(id: another_join_id_box).order(created_at: :desc).page(params[:page]).per(8)

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
