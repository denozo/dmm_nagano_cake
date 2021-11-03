class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @item = Item.all
  end

  def update
  end

  def destroy
  end

  def destroyall
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if CartItem.find_by(item_id: @cart_item.item_id)
      flash[:notice] = '商品の個数を追加しました！'
      redirect_to items_path
    else
      @cart_item.save
      redirect_to items_path
    end

  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end


end
