class User < ApplicationRecord
  require 'digest/sha2'
  # Validations
  validates :email, :password, presence: true
  # TODO valid email regex

  # Callback
  before_save :encrypt_password

  # Determines whether or not the password passed matches with the one persisted for the user
  def valid_password?(password="")
    self.password == Digest::SHA2.hexdigest(password)
  end
  # Generates a new token for the user or nil if any error is arisen during the generation or persisting
  # of the token.
  def generate_token
    begin
      token = SecureRandom.base64
      self.update_columns({ token: token, token_created_at: Time.now, updated_at: Time.now })
      return token
    rescue NotImplementedError, ActiveRecord::ActiveRecordError
      return nil
    end
  end
  # Invalidates the token persisted for an user. Returns true if the token is invalidated successfully
  # or false otherwise
  def invalidate_token
    begin
      if self.token
        self.update_columns({ token: nil, token_created_at: nil, updated_at: Time.now })
        return true
      end
      return false
    rescue ActiveRecord::ActiveRecordError
      return false
    end
  end

  private
  def encrypt_password
    self.password = Digest::SHA2.hexdigest(self.password)
  end
end
