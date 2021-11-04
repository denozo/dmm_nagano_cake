class Public::CartItemsController < ApplicationController


  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @sum = 0
  end

  def update
    @cart_items = CartItem.find(params[:id])
    @cart_items.update(amount: params[:amount])
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroyall
    cart_items = current_customer.cart_items
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
        cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        cart_item.amount += params[:cart_item][:amount].to_i
        cart_item.save
        flash[:notice] = "商品の個数を追加しました！"
        redirect_to cart_items_path

    elsif @cart_item.save
        flash[:notice] = "新規追加しました"
        redirect_to cart_items_path
    else

      render cart_item_path

    end

  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end


end