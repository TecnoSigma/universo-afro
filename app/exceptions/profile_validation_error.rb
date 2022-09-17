# frozen_string_literal: true

# class responsible by rescue password validation errors
class ProfileValidationError < StandardError
  def initialize(message = I18n.t('messages.errors.invalid_profile'))
    super
  end
end
