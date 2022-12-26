# frozen_string_literal: true

# class responsible by create vacant job presenter
class VacantJobPresenter
  def self.exceeded_quantity?(vacant_jobs)
    CandidateVacantJob.exceeded_quantity?(vacant_jobs)
  end
end
