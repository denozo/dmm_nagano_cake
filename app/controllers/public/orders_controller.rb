class Public::OrdersController < ApplicationController


  before_action :authenticate_customer!

  def new
    @addresses = Address.all
    @customer = current_customer
    @order = Order.new

  end

  def confirm

    #ユーザー情報取得

    @customer = current_customer

    # new画面での支払方法の選択値により変更

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

  #カート内の値を取得

    @cart_items = current_customer.cart_items

  #商品合計の計算
    @sum = 0

    @cart_items.each do |cart_item|
      @sum += cart_item.subtotal
    end

  #請求金額の計算(商品合計＋送料)

    @total_payment = @sum + 800
    @order.total_payment = @total_payment.to_i
    @order.shipping_cost = 800
    @order.payment_method = params[:order][:payment_method]
    @order.customer_id = current_customer.id

  def create

    order = Order.new(order_params)
    order.save

    cart_items = current_customer.cart_items
      cart_items.each do |cart_item|
        order_details = OrderDetail.new
        order_details.item_id = cart_item.item.id
        order_details.order_id = order.id
        order_details.price = cart_item.subtotal
        order_details.amount = cart_item.amount
        # order_details.making_status = "0"
        order_details.save
      end

    cart_items = current_customer.cart_items
    cart_items.destroy_all

    redirect_to thanks_orders_path

  end


  def thanks
  end


  end

  def index
    #whereメソッドでログインユーザのデータを取り出す
    @orders = Order.where(customer_id: current_customer.id)

  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @item = Item.all
    
    #商品合計の計算

    @sum = 0

    @order_details.each do |order_detail|
      @sum += order_detail.subtotal
    end    
    
    
    #商品合計はどこで計算させるのか確認
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end

end
