# frozen_string_literal: true

# class responsible by manage company vacant jobs
class CompanyVacantJob < VacantJob
  validates :availabled_quantity,
            :filled_quantity,
            presence: { message: I18n.t('messages.errors.required_field') }

  validates :availabled_quantity,
            :filled_quantity,
            numericality: { greater_than: -1, message: I18n.t('messages.errors.invalid_format') }

  belongs_to :company

  scope :by_profession, lambda { |profession|
    select { |vacant_job| vacant_job.profession.name == profession }.sort_by(&:created_at).reverse
  }
end
