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

  enum :status=>{:xia=>0, :shang=>1}

  has_many :product_images, -> {order(weight: :desc)}, :dependent => :destroy
  has_one :main_product_image, -> {order(weight: :desc)},
          class_name: 'ProductImage'
  scope :onshelf, ->{where(status: 1)}
  private
  def set_default_uuid
    self.uuid = RandomCode.generate_product_uuid
  end
end
