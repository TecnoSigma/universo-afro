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
end
