class ProductCategory < ApplicationRecord
  acts_as_nested_set  :order_column => :position
  has_many :products, dependent: :destroy
end
