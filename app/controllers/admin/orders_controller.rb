class Admin::OrdersController < ApplicationController

  #ログインしていないユーザーが操作できないように制御
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @order_detail = OrderDetail.find(params[:id])
    @item = Item.all
    @customer = Customer.find(@order.customer_id)

    @sum = 0

    @order_details.each do |order_detail|
      @sum += order_detail.subtotal
    end

  end

  def update
    @order = Order.find(params[:id])

    #製作ステータスを自動更新するために紐づくデータを取得
    @order_details = OrderDetail.where(order_id: @order.id)

    if @order.update(order_params)

      #製作ステータスを自動更新する
      if @order.order_status == 'payment_confirmation'
        @order_details.update_all(making_status: 'production_pending')
      end

      redirect_to admin_order_path
    else
      render :show, alert: "更新できませんでした"
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end