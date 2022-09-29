# frozen_string_literal: true

# Class responsible by manage candidates
class Candidate < ApplicationRecord
  validates :first_name,
            :last_name,
            :email,
            :password,
            :state,
            :city,
            :afro_id,
            :status,
            presence: { message: I18n.t('messages.errors.required_field') }

  validates :email,
            uniqueness: { message: I18n.t('messages.errors.already_used') }

  has_one :avatar
  has_many :candidate_vacant_jobs

  enum status: Statuses::CANDIDATE

  before_validation(on: :create) { generate_afro_id! }

  private

  def generate_afro_id!
    self.afro_id = SecureRandom.hex(10)
  end
end
