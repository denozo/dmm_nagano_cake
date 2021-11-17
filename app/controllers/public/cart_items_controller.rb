class Public::CartItemsController < ApplicationController


  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items

    #合計金額の計算
    @sum = 0
    @cart_items.each do |cart_item|
      @sum += cart_item.subtotal
    end

    #カート内に製品が入っているか確認。帰ってくる値がtureならview側でボタン非活性
    @condition = true == @cart_items.blank?

  end

  def update
    @cart_items = CartItem.find(params[:id])

    if @cart_items.update(amount: params[:amount])
      flash[:notice] = "商品の個数を変更しました！"
      redirect_to cart_items_path
    else
      render cart_item_path
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])

    if cart_item.destroy
      flash[:notice] = "商品を削除しました！"
      redirect_to cart_items_path
    end
  end

  def destroyall
    cart_items = current_customer.cart_items

    #ここに商品が既に空ですを機能としてのせたい

    if cart_items.destroy_all
      flash[:notice] = "カートを空にしました！"
      redirect_to cart_items_path
    end
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