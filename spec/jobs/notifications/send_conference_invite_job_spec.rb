# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notifications::SendConferenceInviteJob, type: :job do
  describe '.perform' do
    it 'enqueues a job' do
      expect(Notifications::SendConferenceInviteService).to receive_message_chain(:new, :deliver!) { true }

      name = 'João'
      email = 'acme@acme.com.br'
      filepath = '/universo-afro/app/storage/calendars/e44857cc03afba28ac7405035297feb048911ac4.ics'
      datetime = '23/03/2023 - 18:00hs'
      recruiter = false

      described_class
        .perform_now(name: name, email: email, filepath: filepath, datetime: datetime, recruiter: recruiter)
    end
  end
end
