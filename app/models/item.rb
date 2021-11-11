class Item < ApplicationRecord

  belongs_to :genre

  has_many :order_details
  has_many :cart_items

  attachment :image
  
  validates :name, presence: true
  validates :image, presence: true
  validates :introduction, presence: true
  validates :price, presence: true  

  enum is_active: { 販売停止中: false, 販売中: true}

  def with_tax_price
    (price * 1.1).floor
  end


end