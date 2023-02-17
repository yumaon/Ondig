class Artist::LiveSchedulesController < ApplicationController
  before_action :authenticate_artist_user!
  # Live Schedule一覧画面
  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @live_schedules = @artist_user.live_schedules

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

  # Live Schedule新規登録画面
  def new
    @live_schedule = LiveSchedule.new
  end

  # Live Schedule新規登録
  def create
    @live_schedule = current_artist_user.live_schedules.new(live_schedule_params)
    if @live_schedule.save
      redirect_to artist_artist_user_live_schedules_path
    else
      render :new
    end
  end

  # Live Schedule情報編集
  def edit
    @live_schedule = LiveSchedule.find(params[:id])

    # 他者のLiveSchedule編集画面へ遷移させない
    if @live_schedule.artist_user != current_artist_user
      redirect_to artist_artist_user_live_schedules_path(current_artist_user)
    end
  end

  # Live Schedule情報更新
  def update
    @live_schedule = LiveSchedule.find(params[:id])
    if @live_schedule.update(live_schedule_params)
      redirect_to artist_artist_user_live_schedules_path
    else
      render :edit
    end
  end

  # Live Schedule情報削除
  def destroy
    live_schedule = LiveSchedule.find(params[:id])
    live_schedule.destroy
    redirect_to artist_artist_user_live_schedules_path
  end

  private
  # ストロングパラメータ
  def live_schedule_params
    params.require(:live_schedule).permit(:artist_user_id, :name, :schedule_date, :price, :location)
  end
end
