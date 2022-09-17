require 'rails_helper'

RSpec.describe Avatar, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass name' do
      avatar = FactoryBot.build(:avatar, name: nil)

      expect(avatar).to be_invalid
      expect(avatar.errors.messages[:name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass data' do
      avatar = FactoryBot.build(:avatar, data: nil)

      expect(avatar).to be_invalid
      expect(avatar.errors.messages[:data]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass filename' do
      avatar = FactoryBot.build(:avatar, filename: nil)

      expect(avatar).to be_invalid
      expect(avatar.errors.messages[:filename]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'vailidates relationships' do
    it 'validates relationship 1:1 between Avatar and Jobber' do
      avatar = Avatar.new

      expect(avatar).to respond_to(:jobber)
    end
  end
end
