class CreateProductCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :product_categories do |t|
      t.string :title
      t.integer :weight, default: 0
      t.integer :products_count, default: 0

      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true

      # optional fields
      t.integer :depth, :null => false, :default => 0
      t.integer :children_count, :null => false, :default => 0
      t.integer :position, default: 0
      t.timestamps
    end
    add_index :product_categories, [:title]
    add_index :product_categories, [:position]
  end
end
