require 'rails_helper'

RSpec.describe Profile do
  describe '.list' do
    it 'returns profiles list' do
      expected_result = [['Candidato', 'candidate'],
                         ['Empresa', 'company'],
                         ['Profissional Liberal', 'professional']]

      result = described_class.list

      expect(result).to eq(expected_result)
    end
  end
end
