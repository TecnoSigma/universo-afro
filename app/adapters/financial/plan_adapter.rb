# frozen_string_literal: true

module Financial
  # class responsible by manage plan adapters
  class PlanAdapter
    include ConfigurationsAdapter

    attr_reader :name, :reference, :price

    def initialize(action:)
      @action = action
      @request = case action
                 when :create then Net::HTTP::Post.new(url)
                 end
    end

    def create!(name:, reference:, price:)
      @name = name
      @reference = reference
      @price = price

      result = response

      raise CreatePlanError unless result.code == Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok].to_s

      JSON.parse(result.read_body)['code']
    rescue CreatePlanError => e
      Rails.logger.error("Message: #{e.message} - Backtrace: #{result.read_body}")

      ''
    end

    private

    def body
      PlanBuilder.new(name: @name, reference: @reference, price: @price).mount
    end

    def resource
      '/pre-approvals/request/?'
    end

    def response
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request['Accept'] = 'application/vnd.pagseguro.com.br.v3+json;charset=ISO-8859-1'
      request['Content-Type'] = 'application/json'
      request.body = body.to_json

      http.request(request)
    end
  end
end
