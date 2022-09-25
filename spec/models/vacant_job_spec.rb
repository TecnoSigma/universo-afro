require 'rails_helper'

RSpec.describe VacantJob, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass name' do
      vacant_job = FactoryBot.build(:vacant_job, name: nil)

      expect(vacant_job).to be_invalid
      expect(vacant_job.errors.messages[:name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass category' do
      vacant_job = FactoryBot.build(:vacant_job, category: nil)

      expect(vacant_job).to be_invalid
      expect(vacant_job.errors.messages[:category]).to include('Preenchimento de campo obrigatório!')
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
  end
end
