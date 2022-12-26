# frozen_string_literal: true

# class responsible by manage candidate vacancies
class CandidateVacantJob < VacantJob
  belongs_to :candidate

  MAXIMUN_QUANTITY = 2.freeze

  def self.exceeded_quantity?(vacant_jobs)
    vacant_jobs.count >= MAXIMUN_QUANTITY
  end

  private_constant :MAXIMUN_QUANTITY
end
