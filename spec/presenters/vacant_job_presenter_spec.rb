require 'rails_helper'

RSpec.describe VacantJobPresenter do
  describe '.exceeded_quantity?' do
    it 'returns \'true\' when vacant jobs quantity is equal two' do
      candidate = FactoryBot.create(:candidate)

      profession1 = FactoryBot.create(:profession)
      vacant_job1 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      profession2 = FactoryBot.create(:profession)
      vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      candidate_vacant_job1 = CandidateVacantJob.new(vacant_job1)
      candidate_vacant_job1.profession = profession1
      candidate_vacant_job1.candidate = candidate
      candidate_vacant_job1.save

      candidate_vacant_job2 = CandidateVacantJob.new(vacant_job2)
      candidate_vacant_job2.profession = profession2
      candidate_vacant_job2.candidate = candidate
      candidate_vacant_job2.save

      vacant_jobs = Candidate.find_by(id: candidate.id).candidate_vacant_jobs

      allow(CandidateVacantJob).to receive(:exceeded_quantity?) { true }

      result = described_class.exceeded_quantity?(vacant_jobs)

      expect(result).to eq(true)
    end

    it 'returns \'true\' when vacant jobs quantity is greater than two' do
      candidate = FactoryBot.create(:candidate)

      profession1 = FactoryBot.create(:profession)
      vacant_job1 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      profession2 = FactoryBot.create(:profession)
      vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      profession3 = FactoryBot.create(:profession)
      vacant_job3 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      candidate_vacant_job1 = CandidateVacantJob.new(vacant_job1)
      candidate_vacant_job1.profession = profession1
      candidate_vacant_job1.candidate = candidate
      candidate_vacant_job1.save

      candidate_vacant_job2 = CandidateVacantJob.new(vacant_job2)
      candidate_vacant_job2.profession = profession2
      candidate_vacant_job2.candidate = candidate
      candidate_vacant_job2.save

      candidate_vacant_job3 = CandidateVacantJob.new(vacant_job3)
      candidate_vacant_job3.profession = profession3
      candidate_vacant_job3.candidate = candidate
      candidate_vacant_job3.save

      vacant_jobs = Candidate.find_by(id: candidate.id).candidate_vacant_jobs

      allow(CandidateVacantJob).to receive(:exceeded_quantity?) { true }

      result = described_class.exceeded_quantity?(vacant_jobs)

      expect(result).to eq(true)
    end

    it 'returns \'false\' when vacant jobs quantity is less than two' do
      candidate = FactoryBot.create(:candidate)

      profession = FactoryBot.create(:profession)
      vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      candidate_vacant_job = CandidateVacantJob.new(vacant_job)
      candidate_vacant_job.profession = profession
      candidate_vacant_job.candidate = candidate
      candidate_vacant_job.save

      vacant_jobs = Candidate.find_by(id: candidate.id).candidate_vacant_jobs

      allow(CandidateVacantJob).to receive(:exceeded_quantity?) { false }

      result = described_class.exceeded_quantity?(vacant_jobs)

      expect(result).to eq(false)
    end
  end
end
