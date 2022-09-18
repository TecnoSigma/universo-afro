# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe '.strong_password?' do
    it 'returns \'true\' when password is strong' do
      password = '!!821a%&@c!!@'

      result = described_class.strong_password?(password)

      expect(result).to eq(true)
    end

    it 'returns \'false\' when isn\'t company' do
      password = '123456'

      result = described_class.strong_password?(password)

      expect(result).to eq(false)
    end
  end

  describe '.professional?' do
    it 'returns \'true\' when is a professional' do
      profile = 'professional'

      result = described_class.professional?(profile)

      expect(result).to eq(true)
    end

    it 'returns \'false\' when isn\'t professional' do
      profile = 'anything'

      result = described_class.professional?(profile)

      expect(result).to eq(false)
    end
  end

  describe '.company?' do
    it 'returns \'true\' when is a company' do
      profile = 'company'

      result = described_class.company?(profile)

      expect(result).to eq(true)
    end

    it 'returns \'false\' when password is weak' do
      profile = 'anything'

      result = described_class.company?(profile)

      expect(result).to eq(false)
    end
  end

  describe '.allowed_profile?' do
    it 'returns \'true\' when profile is candidate' do
      profile = 'candidate'

      result = described_class.allowed_profile?(profile)

      expect(result).to eq(true)
    end

    it 'returns \'true\' when profile is company' do
      profile = 'company'

      result = described_class.allowed_profile?(profile)

      expect(result).to eq(true)
    end

    it 'returns \'true\' when profile is professional' do
      profile = 'professional'

      result = described_class.allowed_profile?(profile)

      expect(result).to eq(true)
    end

    it 'returns \'false\' when profile is invalid' do
      profile = 'invalid_profile'

      result = described_class.allowed_profile?(profile)

      expect(result).to eq(false)
    end
  end

  describe '.verification_code' do
    it 'returns a string' do
      result = described_class.verification_code

      expect(result).to be_kind_of(String)
    end

    it 'returns always string with six caracters' do
      code = '123'

      allow(Random).to receive(:rand) { code }

      result = described_class.verification_code.size

      expect(result).to eq(6)
    end
  end
end
