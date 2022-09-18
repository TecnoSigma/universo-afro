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

    it 'no validates when no pass state' do
      candidate = FactoryBot.build(:candidate, state: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:state]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass city' do
      candidate = FactoryBot.build(:candidate, city: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:city]).to include('Preenchimento de campo obrigatório!')
    end

    context 'when never worked' do
      it 'no validates when pass most recent position' do
        candidate = FactoryBot.build(:candidate, :never_worked, most_recent_position: 'anything')

        expect(candidate).to be_invalid
        expect(candidate.errors.messages[:most_recent_position]).to include('Preenchimento de campo inválido!')
      end
    end

    context 'when worked' do
      it 'validates when no pass most recent position' do
        candidate = FactoryBot.build(:candidate, most_recent_position: nil)

        expect(candidate).to be_valid
      end
    end

    it 'no validates when no pass job type' do
      candidate = FactoryBot.build(:candidate, job_type: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:job_type]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass vacancy state' do
      candidate = FactoryBot.build(:candidate, vacancy_state: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:vacancy_state]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass vacancy city' do
      candidate = FactoryBot.build(:candidate, vacancy_city: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:vacancy_city]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'vailidates relationships' do
    it 'validates relationship 1:1 between Candidate and Avatar' do
      candidate = Candidate.new

      expect(candidate).to respond_to(:avatar)
    end

    it 'validates relationship 1:N between Candidate and Profession' do
      candidate = Candidate.new

      expect(candidate).to respond_to(:professions)
    end
  end
end
