class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.string :payment_no #支付单号
      t.string :transaction_no  #支付宝流水号
      t.integer :status, default: 0
      t.decimal :total_money, precision: 10, scale: 2
      t.datetime :payment_at
      t.text :raw_response  #支付宝返回的原始数据

      t.timestamps
    end
    add_index :payments, [:user_id]
    add_index :payments, [:payment_no], unique: true
    add_index :payments, [:transaction_no]
  end
end
