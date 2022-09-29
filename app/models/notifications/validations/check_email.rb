# frozen_string_literal: true

module Notifications
  module Validations
    # Class reponsible by send notifications
    class CheckEmail
      attr_reader :email, :verification_code

      def initialize(email:, verification_code:)
        @email = email
        @verification_code = verification_code
      end

      def deliver!
        response = RestClient.post(uri, payload, headers)

        response.code == Rack::Utils::SYMBOL_TO_STATUS_CODE[:accepted]
      rescue RestClient::Forbidden, RestClient::Unauthorized, RestClient::BadRequest => e
        Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

        false
      end

      private

      def uri
        ENV.fetch('SENDGRID_URI', nil)
      end

      def headers
        { content_type: 'application/json', Authorization: "Bearer #{ENV.fetch('SENDGRID_API_KEY', nil)}" }
      end

      def payload
        { personalizations: [{ to: [{ email: email }] }],
          from: { email: ENV.fetch('SENDGRID_FROM', nil) },
          subject: I18n.t('notifications.validations.check_email.subject'),
          content: [{ type: 'text/html', value: body }] }.to_json
      end

      def body
        I18n.t('notifications.validations.check_email.body', verification_code: verification_code)
      end
    end
  end
end
