# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Financial::CreatePlanJob, type: :job do
  describe '.perform' do
    it 'enqueues a job' do
      name = 'Plano Básico'
      reference = 'basic'
      price = 10.90
      code = SecureRandom.hex(32)

      expect(Financial::PlanService).to receive_message_chain(:new, :create!) { code }

      described_class.perform_now(name: name, reference: reference, price: price)
    end
  end
end
