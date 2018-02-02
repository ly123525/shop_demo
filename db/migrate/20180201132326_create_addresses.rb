class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.integer :address_type #地址类型, 用户地址和订单地址
      t.string :contact_name
      t.string :cellphone
      t.string :address
      t.string :zipcode
      t.timestamps
    end
    add_index :addresses, [:user_id, :address_type]
  end
end
