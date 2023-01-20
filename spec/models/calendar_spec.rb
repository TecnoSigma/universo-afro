require 'rails_helper'

RSpec.describe Calendar do
  describe '.mount!' do
    context 'when ICS file is created' do
      it 'returns hash containing file path' do
        filename = '123abc'
        date_time = '12/12/2050 15:00'.to_datetime

        allow(SecureRandom).to receive(:hex) { filename }
        allow(File).to receive(:write) { nil }
        allow(File).to receive(:chown) { nil }

        expected_result = { file_path: '/universo-afro/app/storage/calendars/123abc.ics', status: 201 }

        result = described_class.mount!(summary: 'any_summary', description: 'any_description', date: date_time)

        expect(result).to eq(expected_result)
      end
    end

    context 'when no pass description' do
      it 'returns hash containing error message' do
        filename = '123abc'
        date_time = '12/12/2050 15:00'.to_datetime

        allow(SecureRandom).to receive(:hex) { filename }
        allow(File).to receive(:write) { nil }
        allow(File).to receive(:chown) { nil }

        expected_result = { error: 'Preenchimento de campo obrigatório!', status: 406 }

        result = described_class.mount!(summary: 'any_summary', description: '', date: date_time)

        expect(result).to eq(expected_result)
      end
    end

    context 'when no pass summary' do
      it 'returns hash containing error message' do
        filename = '123abc'
        date_time = '12/12/2050 15:00'.to_datetime

        allow(SecureRandom).to receive(:hex) { filename }
        allow(File).to receive(:write) { nil }
        allow(File).to receive(:chown) { nil }

        expected_result = { error: 'Preenchimento de campo obrigatório!', status: 406 }

        result = described_class.mount!(summary: '', description: 'any_description', date: date_time)

        expect(result).to eq(expected_result)
      end
    end
  end
end
