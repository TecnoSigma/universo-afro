# frozen_string_literal: true

require 'sendgrid-ruby'

module Notifications
  # class responsible by notifications configuration
  module Configurations
    include SendGrid

    DISPOSITION_NAME = 'attachment'
    CONTENT_TYPE = 'text/html'

    private_constant :DISPOSITION_NAME, :CONTENT_TYPE

    def deliver!
      response = send_grid_api.client.mail._('send').post(request_body: mounted_request)

      response.status_code == Rack::Utils::SYMBOL_TO_STATUS_CODE[:accepted].to_s
    rescue Errno::ENOENT, SocketError => e
      Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

      false
    end

    private

    def mounted_request
      mail = SendGrid::Mail.new(from, subject, mounted_email, mounted_body)

      mail.add_attachment(mounted_attachment) if instance_variables.include?(:@filepath) && filepath

      mail.to_json
    end

    def mounted_email
      SendGrid::Email.new(email: email, name: name)
    end

    def mounted_body
      SendGrid::Content.new(type: CONTENT_TYPE, value: body)
    end

    def mounted_attachment
      attachment = Attachment.new
      attachment.content = Base64.strict_encode64(File.binread(filepath))
      attachment.type = content_type
      attachment.filename = filename
      attachment.disposition = DISPOSITION_NAME
      attachment.content_id = filename

      attachment
    end

    def filename
      @filename ||= filepath.split('/').last
    end

    def content_type
      Rack::Mime.mime_type(extension)
    end

    def extension
      ".#{filepath.split('.').last}"
    end

    def send_grid_api
      SendGrid::API.new(api_key: ENV.fetch('SENDGRID_API_KEY', nil))
    end

    def from
      SendGrid::Email.new(email: ENV.fetch('SENDGRID_FROM', nil))
    end
  end
end
