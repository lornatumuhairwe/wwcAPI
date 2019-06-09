class User < ApplicationRecord
  validates_presence_of :email

  before_create :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.base64.tr('+/=', 'QrT')
  end
end
