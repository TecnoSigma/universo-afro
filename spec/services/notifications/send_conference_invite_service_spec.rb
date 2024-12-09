# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notifications::SendConferenceInviteService do
  describe '#deliver!' do
    xit 'sends conference invite to candidate' do
      name = 'João'
      email = 'joao_da_silva@user.com'
      filepath = '/universo-afro/spec/fixtures/1e1d730d05e4f6026b9c3b4d464a6c869b85ea59.ics'
      datetime = '23/04/2023 - 15:00hs'

      response = double

      allow(response).to receive(:status_code) { '202' }
      allow(RestClient).to receive(:post) { response }

      result = described_class
        .new(name: name, email: email, filepath: filepath, datetime: datetime)
        .deliver!

      expect(result).to eq(true)
    end

    xit 'sends conference invite to recruiter' do
      name = 'João'
      email = 'joao_da_silva@user.com'
      filepath = '/universo-afro/spec/fixtures/1e1d730d05e4f6026b9c3b4d464a6c869b85ea59.ics'
      datetime = '23/04/2023 - 15:00hs'

      response = double

      allow(response).to receive(:status_code) { '202' }
      allow(RestClient).to receive(:post) { response }

      result = described_class
        .new(name: name, email: email, filepath: filepath, datetime: datetime, recruiter: true)
        .deliver!

      expect(result).to eq(true)
    end
  end
end
