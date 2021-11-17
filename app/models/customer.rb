class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :orders
  has_many :cart_items, dependent: :destroy


  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, length: { maximum: 50}
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

  enum is_active: {active: true, withdraw: false }


  def full_address
    '〒' + postal_code + ' ' + address + ' ' + last_name + first_name
  end


end