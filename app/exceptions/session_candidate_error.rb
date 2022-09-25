# frozen_string_literal: true

# class responsible by rescue session verification errors
class SessionCandidateError < StandardError
  def initialize(message = I18n.t('messages.errors.invalid_session'))
    super
  end
end
