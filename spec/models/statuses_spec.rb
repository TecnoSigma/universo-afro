require 'rails_helper'

RSpec.describe Statuses do
  describe 'validates jobber statuses' do
    it 'returns hash containing statuses' do
      result = described_class::CANDIDATE

      expected_result = { pendent: 1, activated: 2, deactivated: 3, cancelled: 4 }

      expect(result).to eq(expected_result)
    end
  end
end
