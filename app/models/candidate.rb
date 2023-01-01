# frozen_string_literal: true

# Class responsible by manage candidates
class Candidate < ApplicationRecord
  include AvatarValidator

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

  has_many :candidate_vacant_jobs

  enum status: Statuses::CANDIDATE

  before_validation(on: :create) { generate_afro_id! }
  before_validation(on: :create) { update_status! }

  def fullname
    "#{first_name} #{last_name}"
  end

  def available_vacant_jobs
    professions
      .map { |profession| CompanyVacantJob.by_profession(profession) }
      .flatten
  end

  private

  def professions
    candidate_vacant_jobs
      .map(&:profession)
      .pluck(:name)
  end

  def generate_afro_id!
    self.afro_id = SecureRandom.hex(10)
  end

  def update_status!
    self.status = 'activated'
  end
end
