# frozen_string_literal: true

# class responsible by rescue password confirmation errors
class PasswordConfirmationError < StandardError
  def initialize(message = I18n.t('messages.errors.password_confirmation'))
    super
  end
end
