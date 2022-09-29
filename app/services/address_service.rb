# frozen_string_literal: true

# Class responsible by get address when pass a postal code
class AddressService
  attr_reader :postal_code

  def initialize(postal_code:)
    @postal_code = postal_code
  end

  def call
    result = Correios::CEP::AddressFinder.get(postal_code)

    return result unless result.present?

    result[:state] = State.find_by(uf: result[:state]).name

    result
  end
end
