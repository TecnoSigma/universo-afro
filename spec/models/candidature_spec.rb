require 'rails_helper'

RSpec.describe Candidature, type: :model do
  describe 'vailidates relationships' do
    it 'validates relationship N:1 between Candidature and Company Vacant Job' do
      candidature = described_class.new

      expect(candidature).to respond_to(:company_vacant_job)
    end

    it 'validates relationship 1:1 between Candidature and Candidate Vacant Job' do
      candidature = described_class.new

      expect(candidature).to respond_to(:candidate_vacant_job)
    end
  end

  it 'validates the creation of a new candidature' do
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

    result = Candidature.new(company_vacant_job: company_vacant_job, candidate_vacant_job: candidate_vacant_job)

    expect(result).to be_valid
  end

  describe '.exceeded_quantity?' do
    it 'returns \'true\' when vacant jobs quantity is equal two' do
      candidate = FactoryBot.create(:candidate)

      profession1 = FactoryBot.create(:profession)
      vacant_job1 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      profession2 = FactoryBot.create(:profession)
      vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      company1 = FactoryBot.create(:company)
      company_vacant_job1 = CompanyVacantJob.new(vacant_job1)
      company_vacant_job1.profession = profession1
      company_vacant_job1.details = 'Any text'
      company_vacant_job1.company = company1
      company_vacant_job1.save!

      company2 = FactoryBot.create(:company)
      company_vacant_job2 = CompanyVacantJob.new(vacant_job2)
      company_vacant_job2.profession = profession2
      company_vacant_job2.details = 'Any text'
      company_vacant_job2.company = company2
      company_vacant_job2.save!

      candidate_vacant_job1 = CandidateVacantJob.new(vacant_job1)
      candidate_vacant_job1.profession = profession1
      candidate_vacant_job1.candidate = candidate
      candidate_vacant_job1.save

      candidate_vacant_job2 = CandidateVacantJob.new(vacant_job2)
      candidate_vacant_job2.profession = profession2
      candidate_vacant_job2.candidate = candidate
      candidate_vacant_job2.save

      Candidature.create(candidate_vacant_job: candidate_vacant_job1, company_vacant_job: company_vacant_job1)
      Candidature.create(candidate_vacant_job: candidate_vacant_job2, company_vacant_job: company_vacant_job2)

      result = described_class.exceeded_quantity?(candidate)
    end

    it 'returns \'true\' when vacant jobs quantity is greater than two' do
      candidate = FactoryBot.create(:candidate)

      profession1 = FactoryBot.create(:profession)
      vacant_job1 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      profession2 = FactoryBot.create(:profession)
      vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      profession3 = FactoryBot.create(:profession)
      vacant_job3 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

      company1 = FactoryBot.create(:company)
      company_vacant_job1 = CompanyVacantJob.new(vacant_job1)
      company_vacant_job1.profession = profession1
      company_vacant_job1.details = 'Any text'
      company_vacant_job1.company = company1
      company_vacant_job1.save!

      company2 = FactoryBot.create(:company)
      company_vacant_job2 = CompanyVacantJob.new(vacant_job2)
      company_vacant_job2.profession = profession2
      company_vacant_job2.details = 'Any text'
      company_vacant_job2.company = company2
      company_vacant_job2.save!

      company3 = FactoryBot.create(:company)
      company_vacant_job3 = CompanyVacantJob.new(vacant_job3)
      company_vacant_job3.profession = profession3
      company_vacant_job3.details = 'Any text'
      company_vacant_job3.company = company3
      company_vacant_job3.save!

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

      Candidature.create(candidate_vacant_job: candidate_vacant_job1, company_vacant_job: company_vacant_job1)
      Candidature.create(candidate_vacant_job: candidate_vacant_job2, company_vacant_job: company_vacant_job2)
      Candidature.create(candidate_vacant_job: candidate_vacant_job3, company_vacant_job: company_vacant_job3)

      result = described_class.exceeded_quantity?(candidate)

      expect(result).to eq(true)
    end

    it 'returns \'false\' when vacant jobs quantity is less than two' do
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

      Candidature.create(candidate_vacant_job: candidate_vacant_job, company_vacant_job: company_vacant_job)

      result = described_class.exceeded_quantity?(candidate)

      expect(result).to eq(false)
    end
  end

  describe '.list' do
    context 'when exist applied candidatures' do
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

        Candidature.create(company_vacant_job: company_vacant_job, candidate_vacant_job: candidate_vacant_job)

        result = described_class.list(candidate)

        expect(result).not_to be_empty
      end
    end

    context 'when no exist applied candidatures' do
      it 'returns empty list' do
        candidate = FactoryBot.create(:candidate)

        result = described_class.list(candidate)

        expect(result).to be_empty
      end
    end
  end
end
