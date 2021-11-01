class RemoveUpdateAtFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :update_at, :datetime
  end
end
