# frozen_string_literal: true

module Financial
  # class responsible by manage session creation job
  class CreateSessionJob < ApplicationJob
    queue_as :financial

    def perform
      Financial::SessionService.create!
    end
  end
end
