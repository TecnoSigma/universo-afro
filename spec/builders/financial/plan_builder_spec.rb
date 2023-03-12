# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Financial::PlanBuilder do
  describe '.mount' do
    it 'mounts request body to create plan in payment gateway' do
      name = 'Plano Básico'
      reference = 'basic'
      price = 10.90

      result = described_class.new(name: name, reference: reference, price: price).mount

      expected_result = { preApproval: {
                            amountPerPayment: '10.9',
                            charge: 'AUTO',
                            name: 'Plano Básico',
                            period: 'MONTHLY' },
                          reference: 'basic'}

      expect(result).to eq(expected_result)
    end
  end
end
