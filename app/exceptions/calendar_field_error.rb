# frozen_string_literal: true

# class responsible by rescue calendar field errors
class CalendarFieldError < StandardError
  def initialize(message = I18n.t('messages.errors.required_field'))
    super
  end
end
