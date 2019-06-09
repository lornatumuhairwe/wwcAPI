require 'rails_helper'

RSpec.describe 'User API' do
  describe '#generate_api_key' do
    before { post '/get_api_key', params: { email: 'test@test.test' } }

    it 'returns user with api key' do
      expect(json['api_key']).not_to be_nil
      expect(json['email']).to eq('test@test.test')
    end
  end
end
