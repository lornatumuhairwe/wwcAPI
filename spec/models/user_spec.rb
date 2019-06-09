require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#generate_api_key' do
    it 'assigns api_key to user on create' do
      user = User.create(email: 'test@test.test')
      expect(user.api_key).not_to be_nil
    end
  end
end
