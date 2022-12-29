require 'rails_helper'

RSpec.describe CandidateVacantJob, type: :model do
  it 'validates inheritance of CandidateVacationJob and VacationJob' do
    expect(described_class).to be < VacantJob
  end

  describe 'vailidates relationships' do
    it 'validates relationship N:1 between Vacant Job and Candidate' do
      vacant_job = described_class.new

      expect(vacant_job).to respond_to(:candidate)
    end

    it 'validates relationship N:1 between Candidate Vacant Job and Candidature' do
      vacant_job = described_class.new

      expect(vacant_job).to respond_to(:candidature)
    end
  end
end
