# frozen_string_literal: true

module Financial
  # class responsible by manage plan in payment gateway
  class PlanService
    attr_reader :name, :reference, :price

    def initialize(name:, reference:, price:)
      @name = name
      @reference = reference
      @price = price
    end

    def create!
      Financial::PlanAdapter
        .new(action: :create)
        .create!(name: name, reference: reference, price: price)
    end
  end
end
