class Artist::PublicUsersController < ApplicationController
  # Artist会員から見る一般会員詳細画面
  def show
    @public_user = PublicUser.find(params[:id])

    # DM機能のための記述
    # Roomを作成した際に、現在ログインしているユーザーと、対象ユーザーの両方をjoinsテーブルに記録するためwhereで取得
    @current_ArtistUser_join = Join.where(artist_user_id: current_artist_user.id)
    @PublicUser_join = Join.where(public_user_id: @public_user.id)

    # 現在ログインしているユーザーと対象ユーザーのメッセージRoomが既に作成されているかを判断
    @current_ArtistUser_join.each do |current_artist|
      @PublicUser_join.each do |other_public|
        if current_artist.room_id == other_public.room_id then
          @isRoom = true
          @roomId = current_artist.room_id
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
