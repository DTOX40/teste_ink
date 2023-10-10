class AddStoreToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :store, null: false, foreign_key: true, default: 1
  end
end
