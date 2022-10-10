# frozen_string_literal: true

# class responsible by rescue password validation errors
class FindActivatedUserError < StandardError
  def initialize(message = I18n.t('messages.errors.activated_user_not_found'))
    super
  end
end
