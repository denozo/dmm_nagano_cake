class Admin::ItemsController < ApplicationController

  #ログインしていないユーザーが操作できないように制御
  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page]).per(10).search(params[:search])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
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

    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :genre_id, :image, :introduction, :price, :is_active)
  end

end