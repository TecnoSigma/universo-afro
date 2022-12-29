# frozen_string_literal: true

# class responsible by manage candidate vacancies
class CandidateVacantJob < VacantJob
  has_one :candidature
  belongs_to :candidate
end
