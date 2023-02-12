# frozen_string_literal: true

# class responsible by manage conferences
class Conference < ApplicationRecord
  include AfroIdGenerator

  validates :start_at,
            :date,
            :horary,
            presence: { message: I18n.t('messages.errors.required_field') }

  validates :reason,
            presence: { message: I18n.t('messages.errors.required_field') },
            if: :refused?

  validates :reason,
            presence: { message: I18n.t('messages.errors.required_field') },
            if: :cancelled?

  belongs_to :candidate
  belongs_to :company

  enum status: Statuses::CONFERENCE

  before_validation(on: :create) { generate_date_time! }

  attr_accessor :date, :horary

  DURATION = 1.hour

  private_constant :DURATION

  private

  def generate_date_time!
    converted_date_time = "#{date} #{horary}".to_datetime

    self.start_at = converted_date_time
    self.finish_at = converted_date_time + DURATION
  end
end
