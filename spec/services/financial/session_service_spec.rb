# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Financial::SessionService do
  describe '#create!' do
    context 'when creates a new session in payment gateway' do
      it 'returns gateway code of created session' do
        code = SecureRandom.hex(64)

        allow_any_instance_of(Financial::SessionAdapter).to receive(:fetch) { code }

        result = described_class.create!

        expect(result).to eq(code)
      end
    end

    context 'when no crates a new session in payment gateway' do
      it 'returns empty string' do
        allow_any_instance_of(Financial::SessionAdapter).to receive(:fetch) { '' }

        result = described_class.create!

        expect(result).to eq('')
      end
    end
  end
end
