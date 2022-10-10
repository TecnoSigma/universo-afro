# frozen_string_literal: true

module Notifications
  module Validations
    # Class reponsible by send notifications to check email
    class CheckEmail
      include Notifications::Configurations

      attr_reader :email, :verification_code, :subject, :body

      def initialize(email:, verification_code:)
        @email = email
        @verification_code = verification_code
        @subject = I18n.t('notifications.validations.check_email.subject')
        @body = I18n.t('notifications.validations.check_email.body', verification_code: verification_code)
      end
    end
  end
end
