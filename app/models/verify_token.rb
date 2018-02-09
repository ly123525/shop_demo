class VerifyToken < ApplicationRecord
  validates :token, :presence => {message: '验证码不能为空'}
  validates :cellphone, :presence => {message: '手机号不能为空'}

  scope :available,  ->{where("expired_at > :time", time: Time.now)}

  def self.upsert cellphone, token
    cond = { cellphone: cellphone }
    record = self.find_by(cond)
    unless record
      record = self.create cond.merge(token: token, expired_at: Time.now + 10.minutes)
    else
      record.update_attributes token: token, expired_at: Time.now + 10.minutes
    end

    record
  end

end
