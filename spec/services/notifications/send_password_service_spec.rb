# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notifications::SendPasswordService do
  describe '#deliver!' do
    xit 'sends password notification to user' do
      name = 'João'
      email = 'joao_da_silva@user.com'
      password = '123456'

      response = double

      allow(response).to receive(:status_code) { '202' }
      allow(RestClient).to receive(:post) { response }

      result = described_class
        .new(name: name, email: email, password: password)
        .deliver!

      expect(result).to eq(true)
    end
  end
end
