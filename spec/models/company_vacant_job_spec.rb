require 'rails_helper'

RSpec.describe CompanyVacantJob, type: :model do
  it 'validates inheritance of CompanyVacationJob and VacationJob' do
    expect(described_class).to be < VacantJob
  end

  describe 'vailidates relationships' do
    it 'validates relationship N:1 between Vacant Job and Company' do
      vacant_job = described_class.new

      expect(vacant_job).to respond_to(:company)
    end
  end

  describe 'validates scopes' do
    it 'filters company vacant jobs by profession' do
      profession_name = 'Advogado'
      profession = FactoryBot.create(:profession, name: profession_name)

      company = FactoryBot.create(:company, status: 'activated')

      company_vacant_job = FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company.id, profession: profession)

      result = described_class.by_profession(profession_name)

      expected_result = [CompanyVacantJob .find_by_category(company_vacant_job.category)]

      expect(result).to eq(expected_result)
    end
  end
end
