# frozen_string_literal: true

# class responsible by rescue authorized user errors
class AuthorizedUserError < StandardError
  def initialize(message = I18n.t('messages.errors.user_not_authorized'))
    super
  end
end
