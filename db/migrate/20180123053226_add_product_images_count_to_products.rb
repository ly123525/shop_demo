class AddProductImagesCountToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :product_images_count, :integer
  end
end
