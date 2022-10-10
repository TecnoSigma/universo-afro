# frozen_string_literal: true

# class responsible by rescue password validation errors
class NotifiedUserError < StandardError
  def initialize(message = I18n.t('messages.errors.notified_user'))
    super
  end
end
