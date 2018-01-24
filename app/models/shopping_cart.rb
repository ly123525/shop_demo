class ShoppingCart < ApplicationRecord
  validates :user_uuid, :presence=> {message: 'uuid 不能为空'}
  validates :product_id, :presence=> {message: '商品i的不能为空'}
  validates :amount, :presence=> {message: '数量不能为空'}
  scope :by_user_uuid, ->(uuid){where(user_uuid: uuid )}
  belongs_to :product

  def self.create_or_update! options = {}
    cond = {
        user_uuid: options[:user_uuid],
        product_id: options[:product_id]
    }

    record = where(cond).first
    if record
      record.update_attributes!(options.merge(amount: record.amount + options[:amount]))
    else
      record = create!(options)
    end

    record
  end
end
