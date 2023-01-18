# frozen_string_literal: true

# Class responsible by manage candidates
class Candidate < ApplicationRecord
  include AvatarValidator
  include AfroIdGenerator

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
  has_many :conferences

  enum status: Statuses::CANDIDATE

  before_validation(on: :create) { update_status! }

  def self.find_by_resource(resource)
    all.detect { |candidate| candidate if candidate.fullname.to_resource == resource }
  end

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

  def update_status!
    self.status = 'activated'
  end
end
