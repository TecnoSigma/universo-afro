require 'rails_helper'

RSpec.describe Profession, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass name' do
      profession = FactoryBot.build(:profession, name: nil)

      expect(profession).to be_invalid
      expect(profession.errors.messages[:name]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'validates relationships' do
    it 'validates relationship 1:N between Profession and VacantJob' do
      profession = described_class.new

      expect(profession).to respond_to(:vacant_jobs)
    end

    it 'validates relationship 1:N between Profession and Professionals' do
      profession = described_class.new

      expect(profession).to respond_to(:professionals)
    end
  end
end
