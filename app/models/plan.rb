# frozen_string_literal: true

# class responsible by manage plans
class Plan < ApplicationRecord
  validates :name,
            :reference,
            :price,
            :status,
            presence: { message: I18n.t('messages.errors.required_field') }

  validates :price,
            numericality: { only_integer: false, greater_than: 0, message: I18n.t('messages.errors.invalid_format') }

  validates :name,
            uniqueness: { message: I18n.t('messages.errors.already_used') }

  enum status: Statuses::PLAN

  CHARGE = 'AUTO'
  PERIOD = 'MONTHLY'

  def self.persist!(name:, reference:, price:)
    gateway_code = Financial::CreatePlanJob.perform_now(name: name, reference: reference, price: price)

    raise CreatePlanError unless gateway_code.present?

    Plan.create!(name: name, reference: reference, price: price, code: gateway_code, status: :activated)

    true
  rescue CreatePlanError => e
    Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

    false
  end
end
