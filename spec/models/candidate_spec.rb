require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass first name' do
      candidate = FactoryBot.build(:candidate, first_name: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:first_name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass last name' do
      candidate = FactoryBot.build(:candidate, last_name: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:last_name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass afro ID' do
      candidate = FactoryBot.build(:candidate, afro_id: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:afro_id]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass status' do
      candidate = FactoryBot.build(:candidate, status: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:status]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'vailidates relationships' do
    it 'validates relationship 1:1 between candidate and Avatar' do
      candidate = Candidate.new

      expect(candidate).to respond_to(:avatar)
    end
  end
end
