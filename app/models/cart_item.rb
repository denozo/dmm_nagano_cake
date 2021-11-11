class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item


  #カート内の小計計算
  def subtotal
    item.with_tax_price * amount
  end

end