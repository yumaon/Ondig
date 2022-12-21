class Artist::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    item = current_artist_user.items.new(item_params)
    item.save
    redirect_to artist_artist_user_items_path
  end

  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @items = @artist_user.items
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
