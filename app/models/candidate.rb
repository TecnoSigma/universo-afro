# frozen_string_literal: true

# Class responsible by manage candidates
class Candidate < ApplicationRecord
  validates :first_name,
            :last_name,
            :state,
            :city,
            :job_type,
            :vacancy_state,
            :vacancy_city,
            :afro_id,
            :status,
            presence: { message: I18n.t('messages.errors.required_field') }

  validate :check_most_recent_position

  has_one :avatar
  has_many :professions

  enum status: Statuses::CANDIDATE

  def check_most_recent_position
    if most_recent_position.present? && never_worked
      errors.add(:most_recent_position, I18n.t('messages.errors.invalid_field'))
    end
  end
end
