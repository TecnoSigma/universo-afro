# frozen_string_literal: true

module Notifications
  # Class reponsible by notification configurations
  module Configurations
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
        subject: subject,
        content: [{ type: 'text/html', value: body }] }.to_json
    end
  end
end
