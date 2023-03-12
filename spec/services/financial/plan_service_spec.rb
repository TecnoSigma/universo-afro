# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Financial::PlanService do
  describe '#create!' do
    context 'when creates a new plan in payment gateway' do
      it 'returns gateway code of created plan' do
        name = 'Plano Básico'
        reference = 'basic'
        price = 10.90
        code = SecureRandom.hex(32)

        allow_any_instance_of(Financial::PlanAdapter).to receive(:create!) { code }

        result = described_class.new(name: name, reference: reference, price: price).create!

        expect(result).to eq(code)
      end
    end

    context 'when no crates a new plan in payment gateway' do
      it 'returns empty string' do
        name = 'Plano Básico'
        reference = 'basic'
        price = 10.90

        allow_any_instance_of(Financial::PlanAdapter).to receive(:create!) { '' }

        result = described_class.new(name: name, reference: reference, price: price).create!

        expect(result).to eq('')
      end
    end
  end
end
