class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation

  validates :email, :presence => {message: '邮箱不能为空'}
  validates :email, uniqueness: true

  validates :password, :presence => {message: '密码不能为空'}, if: :need_validate_password
  validates :password_confirmation, :presence => {message: '密码确认不能不为空'}, if: :need_validate_password
  validates :password, :confirmation => {message: '密码不一致'}, if: :need_validate_password
  validates :password, :length=>{minimum: 6, message:'密码最短为6位'}, if: :need_validate_password

  def user_name
    self.email.split('@').first
  end


  private
  def need_validate_password
    self.new_record? ||
        (!self.password.nil? || !self.password_confirmation.nil?)
  end
end
