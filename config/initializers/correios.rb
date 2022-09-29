# frozen_string_literal: true

# Configuration of Correios-CEP gem

Correios::CEP.configure do |config|
  config.request_timeout = 3 # It configures timeout to 3 seconds
end
