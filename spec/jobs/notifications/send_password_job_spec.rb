# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notifications::SendPasswordJob, type: :job do
  describe '.perform' do
    it 'enqueues a job' do
      expect(Notifications::SendPasswordService).to receive_message_chain(:new, :deliver!) { true }

       email = 'acme@acme.com.br'
       password = 'teste1234'
       name = 'João'

      described_class.perform_now(email: email, password: password, name: name)
    end
  end
end
