require 'rails_helper'

RSpec.describe State, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass name' do
      state = FactoryBot.build(:state, name: nil)

      expect(state).to be_invalid
      expect(state.errors.messages[:name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass external ID' do
      state = FactoryBot.build(:state, external_id: nil)

      expect(state).to be_invalid
      expect(state.errors.messages[:external_id]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'vailidates relationships' do
    it 'validates relationship 1:N between State and City' do
      state = State.new

      expect(state).to respond_to(:cities)
    end
  end
end
