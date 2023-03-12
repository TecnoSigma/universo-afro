# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Financial::CreateSessionJob, type: :job do
  describe '.perform' do
    it 'enqueues a job' do
      code = SecureRandom.hex(64)

      expect(Financial::SessionService).to receive(:create!) { code }

      described_class.perform_now
    end
  end
end
