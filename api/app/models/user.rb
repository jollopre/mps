require 'digest/sha2'

class User < ApplicationRecord
  validates :email, :password, presence: true
  before_save :encrypt_password

  def valid_password?(password = '')
    self.password == Digest::SHA2.hexdigest(password)
  end

  def generate_token
    token = SecureRandom.base64
    update_columns(token: token, token_created_at: Time.now, updated_at: Time.now)
    token
  rescue ActiveRecord::ActiveRecordError
    nil
  end

  def invalidate_token
    update_columns({ token: nil, token_created_at: nil, updated_at: Time.now })
    true
  rescue ActiveRecord::ActiveRecordError
    false
  end

  def full_name
    full_name = [name, surname].select(&:present?).join(' ')
    return nil unless full_name.size > 1
    full_name
  end

  private

  def encrypt_password
    self.password = Digest::SHA2.hexdigest(self.password)
  end
end
