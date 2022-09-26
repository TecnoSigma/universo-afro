require 'rails_helper'

RSpec.describe State, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass name' do
      state = FactoryBot.build(:state, name: nil)

      expect(state).to be_invalid
      expect(state.errors.messages[:name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass UF' do
      state = FactoryBot.build(:state, uf: nil)

      expect(state).to be_invalid
      expect(state.errors.messages[:uf]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass external ID' do
      state = FactoryBot.build(:state, external_id: nil)

      expect(state).to be_invalid
      expect(state.errors.messages[:external_id]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'validates relationships' do
    it 'validates relationship 1:N between State and City' do
      state = State.new

      expect(state).to respond_to(:cities)
    end
  end

  describe '#cities_list' do
    it 'returns cities list of state' do
      state1 = FactoryBot.create(:state)
      state2 = FactoryBot.create(:state)
      city1 = FactoryBot.create(:city, state: state1)
      city2 = FactoryBot.create(:city, state: state2)

      result = State.find_by(name: state1.name).cities_list

      expect(result).to eq([city1.name])
    end
  end
end
