require 'rails_helper'

RSpec.describe Conference, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass date' do
      candidate = FactoryBot.create(:candidate)
      company = FactoryBot.create(:company)
      conference = FactoryBot.build(:conference, company: company, candidate: candidate, date: nil)

      expect(conference).to be_invalid
      expect(conference.errors.messages[:date]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass horary' do
      candidate = FactoryBot.create(:candidate)
      company = FactoryBot.create(:company)
      conference = FactoryBot.build(:conference, company: company, candidate: candidate, horary: nil)

      expect(conference).to be_invalid
      expect(conference.errors.messages[:horary]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass reason to conference woth status of cancelled' do
      candidate = FactoryBot.create(:candidate)
      company = FactoryBot.create(:company)
      conference = FactoryBot.build(:conference,
                                    company: company,
                                    candidate: candidate,
                                    reason: nil,
                                    status: Statuses::CONFERENCE[:cancelled])

      expect(conference).to be_invalid
      expect(conference.errors.messages[:reason]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass reason to conference woth status of refused' do
      candidate = FactoryBot.create(:candidate)
      company = FactoryBot.create(:company)
      conference = FactoryBot.build(:conference,                                                                                                          company: company,
                                    candidate: candidate,
                                    reason: nil,
                                    status: Statuses::CONFERENCE[:refused])

      expect(conference).to be_invalid
      expect(conference.errors.messages[:reason]).to include('Preenchimento de campo obrigatório!')
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

  it 'generates date/time when a new conference is created' do
    date = '12/12/2050'
    horary = '14:00'

    date_time = "#{date} #{horary}".to_datetime

    company = FactoryBot.create(:company)
    candidate = FactoryBot.create(:candidate)

    conference = FactoryBot.build(:conference, date_time: nil)
    conference.candidate = candidate
    conference.company = company
    conference.date = date
    conference.horary = horary

    conference.save!

    result = conference.date_time

    expect(result).to eq(date_time)
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
