# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notifications::CheckEmailJob, type: :job do
  describe '.perform' do
    it 'enqueues a job' do
      expect(Notifications::Validations::CheckEmailService).to receive_message_chain(:new, :deliver!) { true }

      name = 'João'
      email = 'acme@acme.com.br'
      verification_code = '1234'

      described_class.perform_now(name: name, email: email, verification_code: verification_code)
    end
  end
end
