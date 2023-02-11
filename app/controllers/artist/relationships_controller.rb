class Artist::RelationshipsController < ApplicationController
  before_action :artist_set_variables, only:[:artist_follow, :artist_unfollow]
  before_action :public_set_variables, only:[:public_follow, :public_unfollow]

  # followをするとき
  def artist_follow
    current_artist_user.follow_an_artist(params[:artist_user_id])
    @artist_user = ArtistUser.find(params[:artist_user_id])

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

  def public_follow
    current_artist_user.follow_an_public(params[:public_user_id])
    @public_user = PublicUser.find(params[:public_user_id])

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

  # followを外すとき
  def artist_unfollow
    current_artist_user.unfollow_an_artist(params[:artist_user_id])
    @artist_user = ArtistUser.find(params[:artist_user_id])
  end

  def public_unfollow
    current_artist_user.unfollow_an_public(params[:public_user_id])
    @public_user = PublicUser.find(params[:public_user_id])
  end

  # follow一覧
  def followings
    @artist_user = ArtistUser.find(params[:artist_user_id])

    # 取得したArtist会員のフォロー中の退会していないユーザーを取得
    @followings = @artist_user.active_followings.order(created_at: :desc).page(params[:page]).per(9)
  end

  # follower一覧
  def followers
    @artist_user = ArtistUser.find(params[:artist_user_id])

    # 取得したArtist会員のフォロワーの退会していないユーザーを取得
    @followers = @artist_user.active_followers.order(created_at: :desc).page(params[:page]).per(9)
  end

  private

  def artist_set_variables
    @artist = ArtistUser.find(params[:artist_user_id])
    @id_name = "#follow-ajax-a-#{@artist.id}"
  end

  def public_set_variables
    @public = PublicUser.find(params[:public_user_id])
    @id_name = "#follow-ajax-p-#{@public.id}"
  end
end
