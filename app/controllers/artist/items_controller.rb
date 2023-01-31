class Artist::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = current_artist_user.items.new(item_params)
    if @item.save
      redirect_to artist_artist_user_items_path
    else
      render :new
    end
  end

  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @items = @artist_user.items

    @current_ArtistUser_join = Join.where(artist_user_id: current_artist_user.id)
    @ArtistUser_join = Join.where(artist_user_id: @artist_user.id)
    unless @artist_user.id == current_artist_user.id
      @current_ArtistUser_join.each do |current_artist|
        @ArtistUser_join.each do |other_artist|
          if current_artist.room_id == other_artist.room_id then
            @isRoom = true
            @roomId = current_artist.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @join = Join.new
      end
    end

  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to artist_artist_user_items_path
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to artist_artist_user_items_path
  end

  private

  def item_params
    params.require(:item).permit(:artist_user_id, :name, :introduction, :item_image, :price)
  end
end
