class Admin::OrderDetailsController < ApplicationController
  
  #ログインしていないユーザーが操作できないように制御
  before_action :authenticate_admin!
  
  def update
    order_detail = OrderDetail.find(params[:id])

    if order_detail.update(order_detail_params)
      
      #order_detail.order_idで注文履歴詳細のidを指定
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
