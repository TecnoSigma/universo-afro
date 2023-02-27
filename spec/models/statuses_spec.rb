require 'rails_helper'

RSpec.describe Statuses do
  describe 'validates candidate statuses' do
    it 'returns hash containing statuses' do
      result = described_class::CANDIDATE

      expected_result = { pendent: 1, activated: 2, deactivated: 3, cancelled: 4 }

      expect(result).to eq(expected_result)
    end
  end

  describe 'validates professional statuses' do
    it 'returns hash containing statuses' do
      result = described_class::PROFESSIONAL

      expected_result = { pendent: 1, activated: 2, deactivated: 3, cancelled: 4 }

      expect(result).to eq(expected_result)
    end
  end

  describe 'validates company statuses' do
    it 'returns hash containing statuses' do
      result = described_class::COMPANY

      expected_result = { pendent: 1, activated: 2, deactivated: 3, cancelled: 4 }

      expect(result).to eq(expected_result)
    end
  end

  describe 'validates vacant job statuses' do
    it 'returns hash containing statuses' do
      result = described_class::VACANT_JOB

      expected_result = { opened: 1, closed: 2, cancelled: 3 }

      expect(result).to eq(expected_result)
    end
  end

  describe 'validades conference statuses' do
    it 'returns hash containing statuses' do
      result = described_class::CONFERENCE

      expected_result = { pendent: 1, accepted: 2, refused: 3, cancelled: 4 }

      expect(result).to eq(expected_result)
    end
  end

  describe 'validades plan statuses' do
    it 'returns hash containing statuses' do
      result = described_class::PLAN

      expected_result = { pendent: 1, activated: 2, deactivated: 3, cancelled: 4 }

      expect(result).to eq(expected_result)
    end
  end
end
