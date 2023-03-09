# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'

module Financial
  # class responsible by manage payment gateway confugurations
  module Configurations
    private

    def response
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request['Accept'] = 'application/vnd.pagseguro.com.br.v3+json;charset=ISO-8859-1'
      request['Content-Type'] = 'application/json'
      request.body = body

      http.request(request)
    end

    def url
      email = ENV.fetch('PAGSEGURO_EMAIL', nil)
      token = ENV.fetch('PAGSEGURO_TOKEN', nil)

      @url ||= URI("#{ENV.fetch('PAGSEGURO_URL', nil)}#{resource}email=#{email}&token=#{token}")
    end
  end
end
