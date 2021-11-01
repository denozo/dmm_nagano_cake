class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @items = Item.new
    @cart_items = Cart_items.all
  end
end
