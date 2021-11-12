class Admin::HomesController < ApplicationController

  #ログインしていないユーザーが操作できないように制御
  before_action :authenticate_admin!

  def top
    @orders = Order.page(params[:page]).per(10).reverse_order

  end

end