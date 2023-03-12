# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'

module Financial
  # class responsible by manage payment gateway confugurations
  module ConfigurationsAdapter
    private

    def url
      email = ENV.fetch('PAGSEGURO_EMAIL', nil)
      token = ENV.fetch('PAGSEGURO_TOKEN', nil)

      @url ||= URI("#{ENV.fetch('PAGSEGURO_URL', nil)}#{resource}email=#{email}&token=#{token}")
    end
  end
end
