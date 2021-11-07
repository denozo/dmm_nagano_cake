class Admin::ItemsController < ApplicationController

  #ログインしていないユーザーが操作できないように制御
  before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item)
  end

  def show
    @item = Item.find(params[:id])
    @genre = Genre.find(@item.genre_id)
  end

  def edit
    @item = Item.find(params[:id])
    if current_admin
      render "edit"
    else
      redirect_to root_path
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item)
  end

  private

  def item_params
    params.require(:item).permit(:name, :genre_id, :image, :introduction, :price, :is_active)
  end

end