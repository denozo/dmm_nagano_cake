class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :addresses, dependent: :destroy
  has_many :orders
  has_many :cart_items, dependent: :destroy
  
  enum is_active: { 退会: false, 有効: true}

end
