class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = Address.all
    @customer = current_customer
  end

  def confirm
  end

  def thanks
  end

  def create
  end

  def index
  end

  def show
  end
  
  private
  
  def order_oarams
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :order_status)
  end
  
end
