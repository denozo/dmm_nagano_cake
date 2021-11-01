class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @items = Item.new
    @item = Item.find(params[:id])
  end
  
  
  def item_params
    params.require(:item).permit(:name, :genre_id, :image, :introduction, :price, :is_active)
  end
  
  
end
