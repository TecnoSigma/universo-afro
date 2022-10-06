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
end
