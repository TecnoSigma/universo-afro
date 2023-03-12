# frozen_string_literal: true

module Financial
  # class responsible by manage plan builders
  class PlanBuilder
    attr_reader :name, :reference, :price

    def initialize(name:, reference:, price:)
      @name = name
      @reference = reference
      @price = price
    end

    def mount
      { reference: reference,
        preApproval: { name: name,
                       charge: ::Plan::CHARGE,
                       period: ::Plan::PERIOD,
                       amountPerPayment: price.to_s } }
    end
  end
end
