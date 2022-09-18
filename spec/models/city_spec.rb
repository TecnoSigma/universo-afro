require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass name' do
      city = FactoryBot.build(:city, name: nil)

      expect(city).to be_invalid
      expect(city.errors.messages[:name]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'vailidates relationships' do
    it 'validates relationship N:1 between City and State' do
      city = City.new

      expect(city).to respond_to(:state)
    end
  end
end
