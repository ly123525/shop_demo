class Payment < ApplicationRecord
  enum :status=>{:no_pay=>0, :success=>1, :fail=>2}
  belongs_to :user
  has_many :orders

  before_create :gen_payment_no

  def create_from_orders!(user,*orders)
    orders.flatten!

    payment = nil
    transaction do
      payment = user.payments.create!(
                                 total_money: orders.sum(&:total_money)
      )
    orders.each do |order|
      if order.is_paid?
        raise "order#{order.order_no} has_already paid"
      end
      order.payment = payment
      order.save!
    end

    end
    payment
  end

  def is_success?
    self.status == 1
  end

  def do_success_payment! options
    self.transaction do
      self.transaction_no = options[:trade_no]
      self.status = 1
      self.raw_response = options.to_json
      self.payment_at = Time.now
      self.save!

      # 更新订单状态
      self.orders.each do |order|
        if order.is_paid?
          raise "order #{order.order_no} has alreay been paid"
        end

        order.status = 1
        order.payment_at = Time.now
        order.save!
      end
    end
  end

  def do_failed_payment! options
    self.transaction_no = options[:trade_no]
    self.status = 2
    self.raw_response = options.to_json
    self.payment_at = Time.now
    self.save!
  end

  private
  def gen_payment_no
    self.payment_no = RandomCode.generate_utoken(32)
  end
end
