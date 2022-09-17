# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notifications::Validations::CheckEmail do
  describe '#deliver!' do
    it 'sends notification to user' do
      username = 'João da Silva'
      email = 'joao_da_silva@user.com'
      verification_code = Faker::Number.number(digits: 6)

      response = double

      allow(response).to receive(:code) { 202 }
      allow(RestClient).to receive(:post) { response }

      result = described_class
        .new(username: username, email: email, verification_code: verification_code)
        .deliver!

      expect(result).to eq(true)
    end

    it 'no sends when pass invalid payload' do
      username = 'João da Silva'
      email = 'joao_da_silva@user.com'
      verification_code = Faker::Number.number(digits: 6)

      response = double

      allow(RestClient).to receive(:post) { raise RestClient::BadRequest }

      result = described_class
        .new(username: username, email: email, verification_code: verification_code)
        .deliver!

      expect(result).to eq(false)
    end

    it 'no sends notification when isn\'t authorized' do
      username = 'João da Silva'
      email = 'joao_da_silva@user.com'
      verification_code = Faker::Number.number(digits: 6)

      response = double

      allow(RestClient).to receive(:post) { raise RestClient::Unauthorized }

      result = described_class
        .new(username: username, email: email, verification_code: verification_code)
        .deliver!

      expect(result).to eq(false)
    end

    it 'no sends notification when sender email not exist' do
      username = 'João da Silva'
      email = 'joao_da_silva@user.com'
      verification_code = Faker::Number.number(digits: 6)

      response = double

      allow(RestClient).to receive(:post) { raise RestClient::Forbidden }

      result = described_class
        .new(username: username, email: email, verification_code: verification_code)
        .deliver!

      expect(result).to eq(false)
    end
  end
end
