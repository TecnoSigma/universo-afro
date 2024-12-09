# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notifications::Validations::CheckEmailService do
  describe '#deliver!' do
    xit 'sends notification to user' do
      name = 'João'
      email = 'joao_da_silva@user.com'
      verification_code = Faker::Number.number(digits: 6)

      response = double

      allow(response).to receive(:status_code) { '202' }
      allow(RestClient).to receive(:post) { response }

      result = described_class
        .new(name: name, email: email, verification_code: verification_code)
        .deliver!

      expect(result).to eq(true)
    end
  end
end
