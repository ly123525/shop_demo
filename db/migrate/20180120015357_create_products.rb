class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :product_category_id
      t.string :title
      t.integer :status, default: 0
      t.integer :amount, default: 0
      t.string :uuid
      t.decimal :msrp, precision: 10, scale: 2
      t.decimal :price, precision: 10, scale: 2
      t.text :description
      t.timestamps
    end
    add_index :products, [:status, :product_category_id]
    add_index :products, [:product_category_id]
    add_index :products, [:uuid], unique: true
    add_index :products, [:title]
  end
end
