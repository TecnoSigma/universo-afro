# frozen_string_literal: true

# class responsible by manage candidate vacancies
class CandidateVacantJob < VacantJob
  belongs_to :candidate
end
