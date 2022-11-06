require 'rails_helper'

RSpec.describe Logotype, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass name' do
      logotype = FactoryBot.build(:logotype, name: nil)

      expect(logotype).to be_invalid
      expect(logotype.errors.messages[:name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass data' do
      logotype = FactoryBot.build(:logotype, data: nil)

      expect(logotype).to be_invalid
      expect(logotype.errors.messages[:data]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass filename' do
      logotype = FactoryBot.build(:logotype, filename: nil)

      expect(logotype).to be_invalid
      expect(logotype.errors.messages[:filename]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'validates relationships' do
    it 'validates relationship 1:1 between Logotype and Company' do
      logotype = Logotype.new

      expect(logotype).to respond_to(:company)
    end
  end
end
