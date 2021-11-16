class Public::HomesController < ApplicationController

  def top
    @items = Item.page(params[:page]).per(4).reverse_order
    
    #サイドバーのジャンル検索用にデータを呼び出す
    @genres = Genre.all
  end

  def about
  end
end
