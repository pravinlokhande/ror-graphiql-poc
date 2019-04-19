class User < ApplicationRecord
  include Clearance::User
  before_create :set_access_token
  has_secure_token :confirmation_token

  private

  def set_access_token
    self.confirmation_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless User.where(confirmation_token: token).exists?
    end
  end
end
