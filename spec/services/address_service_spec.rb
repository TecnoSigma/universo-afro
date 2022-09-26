require 'rails_helper'

RSpec.describe AddressService do
  describe '#call' do
    it 'returns address data when pass valid postal code' do
      state_name = 'São Paulo'
      uf = 'SP'
      postal_code = '01311000'
      state = FactoryBot.create(:state, name: state_name, uf: uf)

      street_data = { address: 'Avenida Paulista',
                      city: 'São Paulo',
                      complement: '- até 609 - lado ímpar',
                      neighborhood: 'Bela Vista',
                      state: uf,
                      zipcode: '01311000' }

      allow(Correios::CEP::AddressFinder).to receive(:get) { street_data }

      expected_result = { address: 'Avenida Paulista',
                          city: 'São Paulo',
                          complement: '- até 609 - lado ímpar',
                          neighborhood: 'Bela Vista',
                          state: state_name,
                          zipcode: '01311000' }

      result = described_class.new(postal_code: postal_code).call

      expect(result).to eq(expected_result)
    end

    it 'returns empty hash when postal code not exist' do
      postal_code = '00000-000'

      allow(Correios::CEP::AddressFinder).to receive(:get) { {} }

      result = described_class.new(postal_code: postal_code).call

      expect(result).to eq({})
    end

    it 'raises error when pass invalid postal code' do
      postal_code = 'invalid_postal_code'

      expect do
        described_class.new(postal_code: postal_code).call
      end.to raise_error(ArgumentError, 'zipcode in invalid format (valid format: 00000-000)')
    end
  end
end
