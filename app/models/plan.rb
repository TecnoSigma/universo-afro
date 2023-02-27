class Plan < ApplicationRecord
  validates :name,
            :status,
            presence: { message: I18n.t('messages.errors.required_field') }

  validates :name,
            uniqueness: { message: I18n.t('messages.errors.already_used') }

  enum status: Statuses::PLAN
end
