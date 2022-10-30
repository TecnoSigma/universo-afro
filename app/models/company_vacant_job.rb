# frozen_string_literal: true

# class responsible by manage company vacancies
class CompanyVacantJob < VacantJob
  validates :quantity, presence: { message: I18n.t('messages.errors.required_field') }
  validates :quantity, numericality: { greater_than: 0, message: I18n.t('messages.errors.invalid_format') }

  belongs_to :company

  scope :by_profession, ->(profession) do
    select { |vacant_job| vacant_job.profession.name == profession }.sort_by(&:created_at).reverse
  end
end
