require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:team) }
  end

  describe 'associations' do
    it { should belong_to(:team) }
  end
end
