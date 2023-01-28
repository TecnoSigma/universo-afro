# frozen_string_literal: true

module Notifications
  module Validations
    # Class reponsible by send notifications to check email
    class CheckEmailService
      include Notifications::Configurations

      attr_reader :name, :email, :subject, :body

      def initialize(name:, email:, verification_code:)
        @email = email
        @name = name
        @subject = I18n.t('notifications.validations.check_email.subject')
        @body = I18n.t('notifications.validations.check_email.body', verification_code: verification_code)
      end
    end
  end
end
