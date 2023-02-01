class Public::ItemsController < ApplicationController
  # Artist会員のItem一覧画面
  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @items = @artist_user.items

    # DM機能のための記述
    if public_user_signed_in?
      # Roomを作成した際に、現在ログインしているユーザーと、対象ユーザーの両方をjoinsテーブルに記録するためwhereで取得
      @current_PublicUser_join = Join.where(public_user_id: current_public_user.id)
      @ArtistUser_join = Join.where(artist_user_id: @artist_user.id)

      # 現在ログインしているユーザーと対象ユーザーのメッセージRoomが既に作成されているかを判断
      @current_PublicUser_join.each do |current_public|
        @ArtistUser_join.each do |other_artist|
          if current_public.room_id == other_artist.room_id then
            @isRoom = true
            @roomId = current_public.room_id
          end
        end
        # 上記でメッセージRoomが存在しなかった場合、新しくインスタンスを作成するための記述
        if @isRoom
        else
          @room = Room.new
          @join = Join.new
        end
      end
    end
  end
end
