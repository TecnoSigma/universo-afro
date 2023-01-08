require 'rails_helper'

RSpec.describe CompanyVacantJob, type: :model do
  describe 'validades presences' do
    it 'no validates when no pass availabled quantity' do
      vacant_job = FactoryBot.attributes_for(:vacant_job)

      company_vacant_job = CompanyVacantJob.new(vacant_job)
      company_vacant_job.availabled_quantity = nil

      expect(company_vacant_job).to be_invalid
      expect(company_vacant_job.errors.messages[:availabled_quantity]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass filled quantity' do
      vacant_job = FactoryBot.attributes_for(:vacant_job)

      company_vacant_job = CompanyVacantJob.new(vacant_job)
      company_vacant_job.filled_quantity = nil

      expect(company_vacant_job).to be_invalid
      expect(company_vacant_job.errors.messages[:filled_quantity]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass details' do
      vacant_job = FactoryBot.attributes_for(:vacant_job)

      company_vacant_job = CompanyVacantJob.new(vacant_job)
      company_vacant_job.details = nil

      expect(company_vacant_job).to be_invalid
      expect(company_vacant_job.errors.messages[:details]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'validates numericality' do
    it 'no validates when pass availabled quantity as negative number' do
      vacant_job = FactoryBot.attributes_for(:vacant_job)

      company_vacant_job = CompanyVacantJob.new(vacant_job)
      company_vacant_job.filled_quantity = -14

      expect(company_vacant_job).to be_invalid
      expect(company_vacant_job.errors.messages[:filled_quantity]).to include('Formato inválido!')
    end

    it 'no validates when pass filled quantity as negative number' do
      vacant_job = FactoryBot.attributes_for(:vacant_job)

      company_vacant_job = CompanyVacantJob.new(vacant_job)
      company_vacant_job.filled_quantity = -14

      expect(company_vacant_job).to be_invalid
      expect(company_vacant_job.errors.messages[:filled_quantity]).to include('Formato inválido!')
    end
  end

  it 'validates inheritance of CompanyVacationJob and VacationJob' do
    expect(described_class).to be < VacantJob
  end

  describe 'vailidates relationships' do
    it 'validates relationship N:1 between Vacant Job and Company' do
      vacant_job = described_class.new

      expect(vacant_job).to respond_to(:company)
    end

    it 'validates relationship 1:N between Company Vacant Job and Candidature' do
      vacant_job = described_class.new

      expect(vacant_job).to respond_to(:candidatures)
    end
  end

  describe 'validates scopes' do
    it 'filters company vacant jobs by profession' do
      profession_name = 'Advogado'
      profession = FactoryBot.create(:profession, name: profession_name)

      company = FactoryBot.create(:company, status: 'activated')

      company_vacant_job = FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company.id, profession: profession)

      result = described_class.by_profession(profession_name)

      expected_result = [CompanyVacantJob.find_by_category(company_vacant_job.category)]

      expect(result).to eq(expected_result)
    end

    it 'sorts company vacant jobs by profession' do
      profession_name1 = 'Zoólogo'
      profession_name2 = 'Advogado'

      profession1 = FactoryBot.create(:profession, name: profession_name1)
      profession2 = FactoryBot.create(:profession, name: profession_name2)

      company = FactoryBot.create(:company, status: 'activated')

      company_vacant_job1 = FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company.id, profession: profession1)
      company_vacant_job2 = FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company.id, profession: profession2)

      result = described_class.sort_by_profession

      expected_result = [CompanyVacantJob.last, CompanyVacantJob.first]

      expect(result).to eq(expected_result)
    end
  end

  it 'creates vacant jbo ID when a nwew company vacant job is created' do
    profession = FactoryBot.create(:profession)
    company = FactoryBot.create(:company, status: 'activated')
    vacant_job_attributes = FactoryBot.attributes_for(:vacant_job,
                                                      :company_vacant_job,
                                                      company_id: company.id,
                                                      profession: profession,
                                                      vacant_job_id: nil)

    vacant_job = CompanyVacantJob.create(vacant_job_attributes)

    result = vacant_job.vacant_job_id

    expect(result).to be_present
  end
end
