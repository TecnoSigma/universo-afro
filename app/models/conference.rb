# frozen_string_literal: true

# class responsible by manage conferences
class Conference < ApplicationRecord
  include AfroIdGenerator

  validates :date_time,
            presence: { message: I18n.t('messages.errors.required_field') }

  belongs_to :candidate
  belongs_to :company

  enum status: Statuses::CONFERENCE
end
