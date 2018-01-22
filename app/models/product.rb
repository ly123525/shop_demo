class Product < ApplicationRecord
  belongs_to :product_category, :counter_cache => true
  before_create :set_default_uuid
  validates :title, presence: {message: '名称不能为空'}
  validates :status, presence: {message: '状态不能为空'}
  validates :amount, presence: {message:'库存不能为空'}
  validates :amount, numericality: {only_integer: true, message:'库存必须为整数'},
            if: proc{|product| !product.amount.blank?}
  validates :msrp, presence: {message: '市场价格不能为空'}
  validates :msrp, numericality: {message: '市场价格必须为数字'},
            if: proc{|product| !product.msrp.blank?}
  validates :price, presence: {message: '价格不能为空'}
  validates :price, numericality: {message: '价格必须为整数'},
            if: proc{|product| !product.price.blank?}
  validates :description, presence:{message: '描述不能为空'}

  enum :status=>{:shang=>0, :xia=>1}

  private
  def set_default_uuid
    self.uuid = RandomCode.generate_product_uuid
  end
end
