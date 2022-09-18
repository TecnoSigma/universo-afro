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
    it 'validates relationship N:1 between Profession and Candidate' do
      profession = Profession.new

      expect(profession).to respond_to(:candidate)
    end
  end
end
