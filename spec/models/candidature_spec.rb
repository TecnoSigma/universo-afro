require 'rails_helper'

RSpec.describe Candidature, type: :model do
  describe 'vailidates relationships' do
    it 'validates relationship 1:N between Candidature and Company Vacant Job' do
      candidature = described_class.new

      expect(candidature).to respond_to(:company_vacant_jobs)
    end

    it 'validates relationship 1:1 between Candidature and Candidate Vacant Job' do
      candidature = described_class.new

      expect(candidature).to respond_to(:candidate_vacant_job)
    end
  end
end
