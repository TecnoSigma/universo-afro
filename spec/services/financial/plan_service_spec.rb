# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Financial::PlanService do
  describe '#create' do
    context 'when creates a new plan in payment gateway' do
      it 'returns gateway code of created plan' do
        name = 'Plano Básico'
        reference = 'basic'
        price = 10.90
        code = SecureRandom.hex(32)
        body = { code: code, date: '2019-08-10T00:27:53-03:00' }.to_json

        result = double
        allow(result).to receive(:code) { '200' }
        allow(result).to receive(:read_body) { body }
        allow_any_instance_of(Financial::Configurations).to receive(:response) { result }

        gateway_result = described_class.new(name: name, reference: reference, price: price).create!

        expect(gateway_result).to eq(code)
      end
    end

    context 'when no crates a new plan in payment gateway' do
      it 'returns empty string' do
        name = 'Plano Básico'
        reference = 'basic'
        price = 10.90
        code = SecureRandom.hex(32)
        body = {}.to_json

        result = double
        allow(result).to receive(:code) { '400' }
        allow(result).to receive(:read_body) { body }
        allow_any_instance_of(Financial::Configurations).to receive(:response) { result }

        gateway_result = described_class.new(name: name, reference: reference, price: price).create!

        expect(gateway_result).to eq('')
      end
    end
  end
end
