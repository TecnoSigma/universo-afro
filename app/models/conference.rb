# frozen_string_literal: true

# class responsible by manage conferences
class Conference < ApplicationRecord
  include AfroIdGenerator

  validates :date_time,
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

  private

  def refused?
    status == Statuses::CONFERENCE.key(3).to_s
  end

  def cancelled?
    status == Statuses::CONFERENCE.key(4).to_s
  end

  def generate_date_time!
    self.date_time = "#{date} #{horary}".to_datetime
  end
end
