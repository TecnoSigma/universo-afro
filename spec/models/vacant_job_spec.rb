require 'rails_helper'

RSpec.describe VacantJob, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass name' do
      vacant_job = FactoryBot.build(:vacant_job, name: nil)

      expect(vacant_job).to be_invalid
      expect(vacant_job.errors.messages[:name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass kind' do
      vacant_job = FactoryBot.build(:vacant_job, kind: nil)

      expect(vacant_job).to be_invalid
      expect(vacant_job.errors.messages[:kind]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass state' do
      vacant_job = FactoryBot.build(:vacant_job, state: nil)

      expect(vacant_job).to be_invalid
      expect(vacant_job.errors.messages[:state]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass city' do
      vacant_job = FactoryBot.build(:vacant_job, city: nil)

      expect(vacant_job).to be_invalid
      expect(vacant_job.errors.messages[:city]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when creator is invalid' do
      vacant_job = VacantJob.new

      expect do
        vacant_job.creator = 'invalid_creator'
      end.to raise_error(ArgumentError, "'invalid_creator' is not a valid creator")
    end
  end

  describe 'vailidates relationships' do
    it 'validates relationship N:1 between Vacant Job and Candidate' do
      vacant_job = VacantJob.new

      expect(vacant_job).to respond_to(:candidate)
    end
  end
end
