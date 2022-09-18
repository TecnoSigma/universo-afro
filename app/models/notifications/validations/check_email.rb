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
      rescue RestClient::Forbidden, RestClient::Unauthorized, RestClient::BadRequest => error
        Rails.logger.error("Message: #{error.message} - Backtrace: #{error.backtrace}")

        false
      end

      private

      def uri
        ENV['SENDGRID_URI']
      end

      def headers
        { content_type: 'application/json', Authorization: "Bearer #{ENV['SENDGRID_API_KEY']}" }
      end

      def payload
        { 'personalizations': [{ 'to': [{ 'email': email }] }],
          'from': { 'email': ENV['SENDGRID_FROM'] },
          'subject': I18n.t('notifications.validations.check_email.subject'),
          'content': [{ 'type': 'text/html', 'value': body }] }.to_json
      end

      def body
        I18n.t('notifications.validations.check_email.body', verification_code: verification_code)
      end
    end
  end
end
