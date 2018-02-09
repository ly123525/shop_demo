class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation, :token

  CELLPHONE_RE = /\A(\+86|86)?1\d{10}\z/
  EMAIL_RE = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/

  # validates :email, :presence => {message: '邮箱不能为空'}
  # validates :email, uniqueness: true

  validates :password, :presence => {message: '密码不能为空'}, if: :need_validate_password
  validates :password_confirmation, :presence => {message: '密码确认不能不为空'}, if: :need_validate_password
  validates :password, :confirmation => {message: '密码不一致'}, if: :need_validate_password
  validates :password, :length=>{minimum: 6, message:'密码最短为6位'}, if: :need_validate_password

  has_many :addresses, ->{where(:address_type=> 0).order('id desc')} #address_type为0是用户地址， 1为订单地址
  belongs_to :default_address, class_name: :Address
  has_many :orders
  has_many :payments
  validate :validate_email_or_cellphone, on: :create
  def user_name
    self.email.blank? ? self.cellphone : self.email.split('@').first
  end


  private
  def need_validate_password
    self.new_record? ||
        (!self.password.nil? || !self.password_confirmation.nil?)
  end

  # TODO
  # 需要添加邮箱和手机号不能重复的校验
  def validate_email_or_cellphone
    if [self.email, self.cellphone].all? { |attr| attr.nil? }
      self.errors.add :base, "邮箱和手机号其中之一不能为空"
      return false
    else
      if self.cellphone.nil?
        if self.email.blank?
          self.errors.add :email, "邮箱不能为空"
          return false
        else
          unless self.email =~ EMAIL_RE
            self.errors.add :email, "邮箱格式不正确"
            return false
          end
        end
      else
        unless self.cellphone =~ CELLPHONE_RE
          self.errors.add :cellphone, "手机号格式不正确"
          return false
        end

        unless VerifyToken.available.find_by(cellphone: self.cellphone, token: self.token)
          self.errors.add :cellphone, "手机验证码不正确或者已过期"
          return false
        end
      end
    end

    return true
  end
end
