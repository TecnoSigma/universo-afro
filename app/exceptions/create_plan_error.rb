# frozen_string_literal: true

# class responsible by rescue authorized plan creation errors
class CreatePlanError < StandardError
  def initialize(message = I18n.t('messages.errors.plan_creation'))
    super
  end
end
