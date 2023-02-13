class Artist::ProfilesController < ApplicationController
  before_action :authenticate_artist_user!
  # アーティストプロフィール詳細画面
  def show
    @artist_user = ArtistUser.find(params[:id])
    @topic = Topic.order(created_at: :desc).find_by(artist_user_id: @artist_user.id)

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

  # Artistプロフィール（Artist情報）編集画面
  def edit
    @artist_user = ArtistUser.find(params[:id])
  end

  # Artistプロフィール情報（Artist情報）更新
  def update
    @artist_user = ArtistUser.find(params[:id])
    @artist_user.update(profile_params)
    redirect_to profile_artist_artist_user_path(@artist_user)
  end

  private
  # ストロングパラメータ
  def profile_params
    params.require(:artist_user).permit(:profile_image, :genre_id, :activity_location, :header_image, :youtube_url, :introduction)
  end
end
