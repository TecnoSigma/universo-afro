# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notifications::SendPassword do
  describe '#deliver!' do
    it 'sends password notification to user' do
      email = 'joao_da_silva@user.com'
      password = '123456'

      response = double

      allow(response).to receive(:code) { 202 }
      allow(RestClient).to receive(:post) { response }

      result = described_class
        .new(email: email, password: password)
        .deliver!

      expect(result).to eq(true)
    end

    it 'no sends when pass invalid payload' do
      email = 'joao_da_silva@user.com'
      password = '123456'

      response = double

      allow(RestClient).to receive(:post) { raise RestClient::BadRequest }

      result = described_class
        .new(email: email, password: password)
        .deliver!

      expect(result).to eq(false)
    end

    it 'no sends notification when isn\'t authorized' do
      email = 'joao_da_silva@user.com'
      password = '123456'

      response = double

      allow(RestClient).to receive(:post) { raise RestClient::Unauthorized }

      result = described_class
        .new(email: email, password: password)
        .deliver!

      expect(result).to eq(false)
    end

    it 'no sends notification when sender email not exist' do
      email = 'joao_da_silva@user.com'
      password = '123456'

      response = double

      allow(RestClient).to receive(:post) { raise RestClient::Forbidden }

      result = described_class
        .new(email: email, password: password)
        .deliver!

      expect(result).to eq(false)
    end
  end
end
