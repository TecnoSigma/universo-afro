require 'rails_helper'

RSpec.describe Calendar do
  describe '#mount!' do
    context 'when ICS file is created' do
      it 'returns hash containing file path' do
        filename = '123abc'
        candidate = FactoryBot.create(:candidate)
        company = FactoryBot.create(:company)

        conference = FactoryBot.build(:conference)
        conference.candidate = candidate
        conference.company = company
        conference.save

        allow(SecureRandom).to receive(:hex) { filename }
        allow(File).to receive(:write) { nil }
        allow(File).to receive(:chown) { nil }

        expected_result = { file_path: '/universo-afro/app/storage/calendars/123abc.ics', status: 201 }

        result = described_class.new(conference_afro_id: conference.afro_id).mount!

        expect(result).to eq(expected_result)
      end
    end

    context 'when conference is not found' do
      it 'returns hash containing error status' do
        expected_result = { status: 400 }

        result = described_class.new(conference_afro_id: 'invalid_afro_id').mount!

        expect(result).to eq(expected_result)
      end
    end
  end
end
