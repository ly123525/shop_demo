class ProductCategory < ApplicationRecord
  acts_as_nested_set  #:order_column => :position
  has_many :products, dependent: :destroy
  validates :title, :presence => {message: '名称不能为空'}
end
