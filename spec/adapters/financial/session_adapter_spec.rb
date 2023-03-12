# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Financial::SessionAdapter do
  describe '#fetch' do
    context 'when creates a new session in payment gateway' do
      it 'returns gateway code of created session' do
        code = SecureRandom.hex(64)

        allow_any_instance_of(described_class).to receive(:response) { code }

        result = described_class.new(action: :create).fetch

        expect(result).to eq(code)
      end
    end

    context 'when no crates a new plan in payment gateway' do
      it 'returns empty string' do
        allow_any_instance_of(described_class).to receive(:response) { '' }

        result = described_class.new(action: :create).fetch

        expect(result).to eq('')
      end
    end
  end
end
