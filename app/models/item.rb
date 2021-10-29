class Item < ApplicationRecord
  belongs_to :genre
  attachment :image
  
  enum is_active: { 販売停止中: false, 販売中: true}
  #integer型とは書き方が違う
end
