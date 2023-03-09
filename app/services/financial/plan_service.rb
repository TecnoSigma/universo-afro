# frozen_string_literal: true

module Financial
  # class responsible by manage plan in payment gateway
  class PlanService
    include Configurations

    attr_reader :name, :reference, :price

    def initialize(name:, reference:, price:)
      @name = name
      @reference = reference
      @price = price
    end

    def create!
      result = response

      raise CreatePlanError unless result.code == Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok].to_s

      JSON.parse(result.read_body)['code']
    rescue CreatePlanError => e
      Rails.logger.error("Message: #{e.message} - Backtrace: #{result.read_body}")

      ''
    end

    private

    def body
      PlanBuilder.new(name: name, reference: reference, price: price).mount
    end

    def resource
      '/pre-approvals/request/?'
    end
  end
end
