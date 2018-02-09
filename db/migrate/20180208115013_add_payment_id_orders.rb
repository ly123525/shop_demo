class AddPaymentIdOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :payment_id, :integer
    add_column :orders, :status, :integer, default: 0
    add_index :orders, [:payment_id]
  end
end
