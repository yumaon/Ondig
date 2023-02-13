class Artist::RoomsController < ApplicationController
  before_action :authenticate_artist_user!
  # ダイレクトメッセージのやり取りするRoomの作成
  def create
    @room = Room.create
    @join1 = Join.create(:room_id => @room.id, :artist_user_id => current_artist_user.id)
    @join2 = Join.create(params.require(:join).permit(:artist_user_id, :public_user_id, :room_id).merge(:room_id => @room.id))
    redirect_to rooms_artist_artist_users_path(@room.id)
  end

  # ダイレクトメッセージのやり取りしているRoomの一覧
  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    # 取得したArtist会員の参加しているroom.idをmy_room_idに格納
    my_room_id = []
    @artist_user.joins.each do |join|
      my_room_id << join.room.id
    end

    # 自分が参加している、roomのjoinテーブルを取得
    my_joins = Join.where(room_id: my_room_id)

    # 自分のidが含まれないjoinテーブルを取り出す。
    another_join_id_box = []
    my_joins.each do |join|
      if join.artist_user_id.present?
        unless join.artist_user_id == current_artist_user.id
          another_join_id_box << join.id
        end
      elsif join.public_user_id.present?
        another_join_id_box << join.id
      end
    end
    @another_joins = Join.where(id: another_join_id_box).order(created_at: :desc).page(params[:page]).per(8)
  end

  # ダイレクトメッセージRoomの詳細画面
  def show
    @artist_user = current_artist_user
    @room = Room.find(params[:id])
    if Join.where(artist_user_id: current_artist_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @joins = @room.joins
    else
      redirect_to artist_artist_user_rooms_path(@artist_user)
    end
  end
end
