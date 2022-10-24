# frozen_string_literal: true

# class responsible by manage company vacancies
class CompanyVacantJob < VacantJob
  belongs_to :company

  scope :by_profession, ->(profession) do
    select { |vacant_job| vacant_job.profession.name == profession }.sort_by(&:created_at).reverse
  end
end
