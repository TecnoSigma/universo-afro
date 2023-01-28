# frozen_string_literal: true

module Notifications
  # Class reponsible by notification of password send
  class SendConferenceInviteService
    include Notifications::Configurations

    attr_reader :name, :email, :subject, :body, :filepath

    def initialize(name:, email:, filepath:, datetime:, recruiter: false)
      @name = name
      @email = email
      @body = I18n.t('notifications.send_conference_invite.body', datetime: datetime)
      @filepath = filepath
      @subject = if recruiter
                   I18n.t('notifications.send_conference_invite.recruiter.subject', candidate_name: name)
                 else
                   I18n.t('notifications.send_conference_invite.candidate.subject', company_name: name)
                 end
    end
  end
end
