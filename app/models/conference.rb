# frozen_string_literal: true

# class responsible by manage conferences
class Conference < ApplicationRecord
  include AfroIdGenerator

  validates :date_time,
            :date,
            :horary,
            presence: { message: I18n.t('messages.errors.required_field') }

  belongs_to :candidate
  belongs_to :company

  enum status: Statuses::CONFERENCE

  before_validation(on: :create) { generate_date_time! }

  attr_accessor :date, :horary

  private

  def generate_date_time!
    self.date_time = "#{date} #{horary}".to_datetime
  end
end
