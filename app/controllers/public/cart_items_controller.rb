class Public::CartItemsController < ApplicationController

  def index
    @cart_item = CartItem.all
  end

  def update
  end

  def destroy
  end

  def destroyall
  end

  def create
    # binding.pry
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
    redirect_to items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end


end
