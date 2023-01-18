require 'rails_helper'

RSpec.describe Conference, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass date' do
      conference = FactoryBot.build(:conference, date: nil)

      expect(conference).to be_invalid
      expect(conference.errors.messages[:date]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass horary' do
      conference = FactoryBot.build(:conference, horary: nil)

      expect(conference).to be_invalid
      expect(conference.errors.messages[:horary]).to include('Preenchimento de campo obrigatório!')
    end
  end

  it 'generates afro ID when a new conference is created' do
    company = FactoryBot.create(:company)
    candidate = FactoryBot.create(:candidate)

    conference = FactoryBot.build(:conference, afro_id: nil)
    conference.candidate = candidate
    conference.company = company

    conference.save!

    result = conference.afro_id

    expect(result).to be_present
  end

  describe 'validates relationships' do
    it 'validates relationships N:1 between Conference and Candidate' do
      conference = described_class.new

      expect(conference).to respond_to(:candidate)
    end

    it 'validates relationships N:1 between Conference and Company' do
      conference = described_class.new

      expect(conference).to respond_to(:company)
    end
  end
end
