# frozen_string_literal: true

# class responsible by manage company vacancies
class CompanyVacantJob < VacantJob
  belongs_to :company
end
