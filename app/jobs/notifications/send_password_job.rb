# frozen_string_literal: true

module Notifications
  # class responsible by manage send password job
  class SendPasswordJob < ApplicationJob
    queue_as :notification

    def perform(email:, password:, name: nil)
      Notifications::SendPasswordService
        .new(email: email, password: password, name: name)
        .deliver!
    end
  end
end
