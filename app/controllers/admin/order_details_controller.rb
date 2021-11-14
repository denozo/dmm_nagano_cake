class Admin::OrderDetailsController < ApplicationController

  #ログインしていないユーザーが操作できないように制御
  before_action :authenticate_admin!

  def update
    order_detail = OrderDetail.find(params[:id])
    order = Order.find(order_detail.order_id)

    if order_detail.update(order_detail_params)

      # 製作ステータスが一つでも製作中になったら注文ステータスを製作中にする
      if order_detail.making_status == 'in_production'
        order.update(order_status: 'in_production')
      end

      #ここから注文ステータスを「発送準備中」に自動更新する動作を実装
      
      #orderに紐づくorder_detailのデータをwhereメソッドで取得
      order_details = OrderDetail.where(order_id: order.id)
      #pluckメソッドでカラムの値を配列で取得。
      ary = order_details.pluck(:making_status)
      #all?メソッドで全ての値がproduction_completeである場合はtureを返す
      result = ary.all?{|making_status| making_status == "production_complete"}
      #結果がtureだった場合注文ステータスの自動更新
      if result == true
        order.update(order_status: 'delivery_preparation')
      else
      end


      # order_detail.order_idで注文履歴詳細のidを指定
      redirect_to admin_order_path(order_detail.order_id)
    else
      render :show, alert: "更新できませんでした"
    end

  end

  private


  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end