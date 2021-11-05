class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = Address.all
    @customer = current_customer
  end

  def confirm
    
    @sum = 0

    if params[:order][:select_address] == "1"

      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name

    elsif params[:order][:select_address] == "2"

      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    elsif params[:order][:select_address] == "3"

      @order = Order.new(order_params)

    else

      redirect_to cart_items_path

    end
    
    @order = current_customer.orders.new(order_params)
    @order.save
    
    @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        @order_details = @oder.order_items.new
        @order_details.item_id = cart_item.item.id
        @order_details.item_id = cart_item.item.name
        @order_details.item_id = cart_item.item.price
        @order_details.item_id = cart_item.amount
        @order_details.save
      end
      
    
    cart_items = current_customer.cart_items
    cart_items.destroy_all
    redirect_to thanks_orders_path

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


  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :order_status)
  end

end
