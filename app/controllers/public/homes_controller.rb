class Public::HomesController < ApplicationController

  def top
    @items = Item.page(params[:page]).per(4).reverse_order
  end

  def about
  end
end
