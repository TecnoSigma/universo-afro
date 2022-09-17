# frozen_string_literal: true

# class responsible by rescue password validation errors
class PasswordValidationError < StandardError
  def initialize(message = I18n.t('messages.errors.invalid_password'))
    super
  end
end
