# frozen_string_literal: true

module Notifications
  # class responsible by manage check email job
  class CheckEmailJob < ApplicationJob
    queue_as :notification

    def perform(name:, email:, verification_code:)
      Notifications::Validations::CheckEmailService
        .new(name: name, email: email, verification_code: verification_code)
        .deliver!
    end
  end
end
