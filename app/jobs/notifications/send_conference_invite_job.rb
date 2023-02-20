# frozen_string_literal: true

module Notifications
  # class responsible by manage send conference invite job
  class SendConferenceInviteJob < ApplicationJob
    queue_as :notification

    def perform(name:, email:, filepath:, datetime:, recruiter: false)
      Notifications::SendConferenceInviteService
        .new(name: name, email: email, filepath: filepath, datetime: datetime, recruiter: recruiter)
        .deliver!
    end
  end
end
