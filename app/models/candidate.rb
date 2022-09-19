# frozen_string_literal: true

# Class responsible by manage candidates
class Candidate < ApplicationRecord
  validates :first_name,
            :last_name,
            :state,
            :city,
            :afro_id,
            :status,
            presence: { message: I18n.t('messages.errors.required_field') }

  has_one :avatar
  has_many :professions
  has_many :vacant_jobs

  enum status: Statuses::CANDIDATE
end
