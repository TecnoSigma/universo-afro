require 'rails_helper'

RSpec.describe Credit, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass url' do
      credit = FactoryBot.build(:credit, url: nil)

      expect(credit).to be_invalid
      expect(credit.errors.messages[:url]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass description' do
      credit = FactoryBot.build(:credit, description: nil)

      expect(credit).to be_invalid
      expect(credit.errors.messages[:description]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass title' do
      credit = FactoryBot.build(:credit, title: nil)

      expect(credit).to be_invalid
      expect(credit.errors.messages[:title]).to include('Preenchimento de campo obrigatório!')
    end
  end
end
