class Artist::ProfileTopicsController < ApplicationController
  before_action :authenticate_artist_user!
  # Artistプロフィール画面上のトピックス一覧画面
  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @topics = @artist_user.topics.order(created_at: :desc).page(params[:page]).per(10)
    @tag_lists = Tag.all

    # DM機能のための記述
    # Roomを作成した際に、現在ログインしているユーザーと、対象ユーザーの両方をjoinsテーブルに記録するためwhereで取得
    @current_ArtistUser_join = Join.where(artist_user_id: current_artist_user.id)
    @ArtistUser_join = Join.where(artist_user_id: @artist_user.id)

    # 対象ユーザーが現在ログインしているユーザーではない場合
    unless @artist_user.id == current_artist_user.id
      # 現在ログインしているユーザーと対象ユーザーのメッセージRoomが既に作成されているかを判断
      @current_ArtistUser_join.each do |current_artist|
        @ArtistUser_join.each do |other_artist|
          if current_artist.room_id == other_artist.room_id then
            @isRoom = true
            @roomId = current_artist.room_id
          end
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
