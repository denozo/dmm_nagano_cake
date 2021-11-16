class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(8).reverse_order.search(params[:search])
    
    #商品一覧に表示する商品の件数を計算
    @itemscount = @items.count
    
    #会員には販売停止中のitemは非表示にする。
    @items = @items.where.not(is_active: '販売停止中')
    
    #サイドバーのジャンル検索用にデータを呼び出す
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @customer = current_customer
    @cart_item = CartItem.new
    
    #サイドバーのジャンル検索用にデータを呼び出す
    @genres = Genre.all
  end



  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end