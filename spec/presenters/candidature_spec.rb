require 'rails_helper'

RSpec.describe CandidaturePresenter do
  describe '.exceeded_quantity?' do
    it 'returns \'true\' when vacant jobs quantity is equal two' do
      candidate = FactoryBot.create(:candidate)

      allow(Candidature).to receive(:exceeded_quantity?) { true }

      result = described_class.exceeded_quantity?(candidate)

      expect(result).to eq(true)
    end

    it 'returns \'false\' when vacant jobs quantity is equal two' do
      candidate = FactoryBot.create(:candidate)

      allow(Candidature).to receive(:exceeded_quantity?) { false }

      result = described_class.exceeded_quantity?(candidate)

      expect(result).to eq(false)
    end
  end
end
