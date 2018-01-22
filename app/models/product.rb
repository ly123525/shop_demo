class Product < ApplicationRecord
  belongs_to :product_category, :counter_cache => true
  before_create :set_default_uuid


  private
  def set_default_uuid
    self.uuid = RandomCode.generate_product_uuid
  end
end
