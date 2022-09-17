# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPresenter do
  describe '.professional?' do
    it 'returns \'true\' when is a professional' do
      profile = 'professional'

      allow(User).to receive(:professional?) { true }

      result = described_class.professional?(profile)

      expect(result).to eq(true)
    end

    it 'returns \'false\' when isn\'t professional' do
      profile = 'professional'

      allow(User).to receive(:professional?) { false }

      result = described_class.professional?(profile)

      expect(result).to eq(false)
    end
  end

  describe '.company?' do
    it 'returns \'true\' when is a company' do
      profile = 'company'

      allow(User).to receive(:company?) { true }

      result = described_class.company?(profile)

      expect(result).to eq(true)
    end

    it 'returns \'false\' when isn\'t company' do
      profile = 'company'

      allow(User).to receive(:company?) { false }

      result = described_class.company?(profile)

      expect(result).to eq(false)
    end
  end
end
