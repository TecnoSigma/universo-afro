# frozen_string_literal: true

# class responsible by manager candidatures
class Candidature < ApplicationRecord
  belongs_to :company_vacant_job
  belongs_to :candidate_vacant_job

  MAXIMUN_QUANTITY = 2

  def self.exceeded_quantity?(candidate)
    candidatures_list(candidate).compact.count >= MAXIMUN_QUANTITY
  end

  def self.candidatures_list(candidate)
    candidate
      .candidate_vacant_jobs
      .inject([]) { |list, vacant_job| list << vacant_job.candidature }
  end

  private_constant :MAXIMUN_QUANTITY
  private_class_method :candidatures_list
end
