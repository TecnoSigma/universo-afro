# frozen_string_literal: true

module Notifications
  # Class reponsible by send password
  class SendPassword
    attr_reader :email, :password

    def initialize(email:, password:)
      @email = email
      @password = password
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
        subject: I18n.t('notifications.send_password.subject'),
        content: [{ type: 'text/html', value: body }] }.to_json
    end

    def body
      I18n.t('notifications.send_password.body', password: password)
    end
  end
end
