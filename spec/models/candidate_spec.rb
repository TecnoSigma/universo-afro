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

    it 'no validates when no pass email' do
      candidate = FactoryBot.build(:candidate, email: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:email]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass password' do
      candidate = FactoryBot.build(:candidate, password: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:password]).to include('Preenchimento de campo obrigatório!')
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
  end

  it 'no validates when status is invalid' do
    candidate = Candidate.new

    expect do
      candidate.status = 'invalid_status'
    end.to raise_error(ArgumentError, "'invalid_status' is not a valid status")
  end

  it 'generates afro ID when a nem candidate is created' do
    candidate = FactoryBot.build(:candidate, afro_id: nil)
    candidate.save!

    result = candidate.afro_id

    expect(result).to be_present
  end

  describe 'validates relationships' do
    it 'validates relationship 1:1 between Candidate and Avatar' do
      candidate = described_class.new

      expect(candidate).to respond_to(:avatar)
    end

    it 'validates relationship 1:N between Candidate and CandidateVacantJob' do
      candidate = described_class.new

      expect(candidate).to respond_to(:candidate_vacant_jobs)
    end
  end
end
