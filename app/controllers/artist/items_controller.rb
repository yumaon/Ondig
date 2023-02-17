class Artist::ItemsController < ApplicationController
  before_action :authenticate_artist_user!
  # Item新規登録画面
  def new
    @item = Item.new
  end

  # Item新規登録アクション
  def create
    @item = current_artist_user.items.new(item_params)
    if @item.save
      redirect_to artist_artist_user_items_path
    else
      render :new
    end
  end

  # Item一覧画面
  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @items = @artist_user.items

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

  # Item編集画面
  def edit
    @item = Item.find(params[:id])

    # 他者のItem編集画面へ遷移させない
    if @item.artist_user != current_artist_user
      redirect_to artist_artist_user_items_path(current_artist_user)
    end
  end

  # Item情報更新
  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to artist_artist_user_items_path
  end

  # Item情報削除
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to artist_artist_user_items_path
  end

  private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:artist_user_id, :name, :introduction, :item_image, :price)
  end
end
