# frozen_string_literal: true

# class responsible by manage company vacant jobs
class CompanyVacantJob < VacantJob
  validates :availabled_quantity,
            :filled_quantity,
            :details,
            presence: { message: I18n.t('messages.errors.required_field') }

  validates :availabled_quantity,
            :filled_quantity,
            numericality: { greater_than: -1, message: I18n.t('messages.errors.invalid_format') }

  belongs_to :company

  before_validation(on: :create) { generate_vacant_job_id! }

  scope :by_profession, lambda { |profession|
    select { |vacant_job| vacant_job.profession.name == profession }.sort_by(&:created_at).reverse
  }

  def generate_vacant_job_id!
    self.vacant_job_id = SecureRandom.hex(10)
  end
end
