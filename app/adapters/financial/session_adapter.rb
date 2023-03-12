# frozen_string_literal: true

module Financial
  # class responsible by manage session adapters
  class SessionAdapter
    include ConfigurationsAdapter

    attr_reader :action, :request

    def initialize(action:)
      @action = action
      @request = case action
                 when :create then Net::HTTP::Post.new(url)
                 end
    end

    def fetch
      response
    end

    private

    def response
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request['Content-Type'] = 'application/json'

      response = Nokogiri::XML(http.request(request).read_body)

      response.xpath('//session').children.children.text
    end

    def resource
      case action
      when :create then '/sessions?'
      end
    end
  end
end
