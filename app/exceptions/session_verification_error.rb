# frozen_string_literal: true

# class responsible by rescue session verification errors
class SessionVerificationError < StandardError
  def initialize(message = I18n.t('messages.errors.invalid_session'))
    super
  end
end
