# frozen_string_literal: true

# class responsible by rescue authorized user errors
class FindUserError < StandardError
  def initialize(message = I18n.t('messages.errors.user_not_found'))
    super
  end
end
