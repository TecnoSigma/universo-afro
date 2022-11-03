require 'rails_helper'

RSpec.describe VacantJobFill do
  describe '#call' do
    it 'updates availabled vacant jobs quantiy of company' do
      availabled_quantity = 10
      profession = FactoryBot.create(:profession, name: 'Medico')
      company = FactoryBot.create(:company, status: 'activated')
      candidate = FactoryBot.create(:candidate, status: 'activated')
      candidate_vacant_job = FactoryBot.create(
        :vacant_job,
        :candidate_vacant_job,
        candidate_id: candidate.id,
        profession: profession
      )
      company_vacant_job = FactoryBot.create(
        :vacant_job,
        :company_vacant_job,
        company_id: company.id,
        profession: profession,
        availabled_quantity: availabled_quantity
      )

      described_class
        .new(company_vacant_job_id: company_vacant_job.id, candidate_vacant_job_id: candidate_vacant_job.id)
        .call

      result = CompanyVacantJob.find_by(id: company_vacant_job.id).availabled_quantity

      expected_result = availabled_quantity - 1

      expect(result).to eq(expected_result)
    end

    it 'updates filled vacant jobs quantiy of company' do
      availabled_quantity = 5
      filled_quantity = 10
      profession = FactoryBot.create(:profession, name: 'Medico')
      company = FactoryBot.create(:company, status: 'activated')
      candidate = FactoryBot.create(:candidate, status: 'activated')
      candidate_vacant_job = FactoryBot.create(
        :vacant_job,
        :candidate_vacant_job,
        candidate_id: candidate.id,
        profession: profession
      )
      company_vacant_job = FactoryBot.create(
        :vacant_job,
        :company_vacant_job,
        company_id: company.id,
        profession: profession,
        availabled_quantity: availabled_quantity,
        filled_quantity: filled_quantity
      )

      described_class
        .new(company_vacant_job_id: company_vacant_job.id, candidate_vacant_job_id: candidate_vacant_job.id)
        .call

      result = CompanyVacantJob.find_by(id: company_vacant_job.id).filled_quantity

      expected_result = filled_quantity + 1

      expect(result).to eq(expected_result)
    end

    it 'updates status of candidate vacant job to closed' do
      profession = FactoryBot.create(:profession, name: 'Medico')
      company = FactoryBot.create(:company, status: 'activated')
      candidate = FactoryBot.create(:candidate, status: 'activated')
      candidate_vacant_job = FactoryBot.create(
        :vacant_job,
        :candidate_vacant_job,
        candidate_id: candidate.id,
        profession: profession
      )
      company_vacant_job = FactoryBot.create(
        :vacant_job,
        :company_vacant_job,
        status: 'opened',
        company_id: company.id,
        profession: profession,
        availabled_quantity: 10
      )

      described_class
        .new(company_vacant_job_id: company_vacant_job.id, candidate_vacant_job_id: candidate_vacant_job.id)
        .call

      result = CandidateVacantJob.find_by(id: candidate_vacant_job.id).status

      expected_result = 'closed'

      expect(result).to eq(expected_result)
    end

    it 'updates status of company vacant job to filled when quantity is zeroed' do
      profession = FactoryBot.create(:profession, name: 'Medico')
      company = FactoryBot.create(:company, status: 'activated')
      candidate = FactoryBot.create(:candidate, status: 'activated')
      candidate_vacant_job = FactoryBot.create(
        :vacant_job,
        :candidate_vacant_job,
        candidate_id: candidate.id,
        profession: profession
      )
      company_vacant_job = FactoryBot.create(
        :vacant_job,
        :company_vacant_job,
        status: 'opened',
        availabled_quantity: 1,
        company_id: company.id,
        profession: profession,
      )

      described_class
        .new(company_vacant_job_id: company_vacant_job.id, candidate_vacant_job_id: candidate_vacant_job.id)
        .call

      result = CompanyVacantJob.find_by(id: company_vacant_job.id).status

      expected_result = 'closed'

      expect(result).to eq(expected_result)
    end

    it 'returns \'false\' then occurs errors during recipe execution' do
      profession = FactoryBot.create(:profession, name: 'Medico')
      company = FactoryBot.create(:company, status: 'activated')
      candidate = FactoryBot.create(:candidate, status: 'activated')
      candidate_vacant_job = FactoryBot.create(
        :vacant_job,
        :candidate_vacant_job,
        candidate_id: candidate.id,
        profession: profession
      )
      company_vacant_job = FactoryBot.create(
        :vacant_job,
        :company_vacant_job,
        status: 'opened',
        availabled_quantity: 1,
        company_id: company.id,
        profession: profession,
      )

      allow(CandidateVacantJob).to receive_message_chain(:find_by, :update!) { false }

      result = described_class
                 .new(company_vacant_job_id: company_vacant_job.id, candidate_vacant_job_id: candidate_vacant_job.id)
                 .call

      expect(result).to eq(false)
    end
  end
end
