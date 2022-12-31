require 'rails_helper'

RSpec.describe CandidaturePresenter do
  describe '.exceeded_quantity?' do
    it 'returns \'true\' when vacant jobs quantity is equal two' do
      candidate = FactoryBot.create(:candidate)

      allow(Candidature).to receive(:exceeded_quantity?) { true }

      result = described_class.exceeded_quantity?(candidate)

      expect(result).to eq(true)
    end

    it 'returns \'false\' when vacant jobs quantity is equal two' do
      candidate = FactoryBot.create(:candidate)

      allow(Candidature).to receive(:exceeded_quantity?) { false }

      result = described_class.exceeded_quantity?(candidate)

      expect(result).to eq(false)
    end
  end

  describe '.candidatures_list' do
    it 'returns candidatures list' do
      profession = FactoryBot.create(:profession, name: 'Rei')

      vacant_job1 = FactoryBot.attributes_for(:vacant_job, details: 'Any text', remote: false, alert: false)
      vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      company = FactoryBot.create(:company)
      company_vacant_job = CompanyVacantJob.new(vacant_job1)
      company_vacant_job.profession = profession
      company_vacant_job.company = company
      company_vacant_job.save!

      candidate = FactoryBot.create(:candidate)
      candidate_vacant_job = CandidateVacantJob.new(vacant_job2)
      candidate_vacant_job.profession = profession
      candidate_vacant_job.candidate = candidate
      candidate_vacant_job.save!

      candidature = Candidature.create(company_vacant_job: company_vacant_job, candidate_vacant_job: candidate_vacant_job)

      allow(Candidature).to receive(:list) { [candidature] }

      result = described_class.candidatures_list(candidate)

      expect(result).to eq([candidature])
    end

    it 'returns empty list when no exists candidatures' do
      candidate = FactoryBot.create(:candidate)

      allow(Candidature).to receive(:list) { [] }

      result = described_class.candidatures_list(candidate)

      expect(result).to be_empty
    end
  end
end
