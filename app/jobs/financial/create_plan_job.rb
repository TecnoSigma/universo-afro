# frozen_string_literal: true

module Financial
  # class responsible by manage plan creation job
  class CreatePlanJob < ApplicationJob
    queue_as :financial

    def perform(name:, reference:, price:)
      Financial::PlanService
        .new(name: name, reference: reference, price: price)
        .create!
    end
  end
end
