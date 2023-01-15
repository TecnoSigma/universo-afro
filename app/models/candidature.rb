# frozen_string_literal: true

# class responsible by manager candidatures
class Candidature < ApplicationRecord
  has_one :candidate, through: :candidate_vacant_job
  belongs_to :company_vacant_job
  belongs_to :candidate_vacant_job

  MAXIMUM_QUANTITY = 2

  def self.exceeded_quantity?(candidate)
    list(candidate).count >= MAXIMUM_QUANTITY
  end

  def self.list(candidate)
    candidate
      .candidate_vacant_jobs
      .inject([]) { |list, vacant_job| list << vacant_job.candidature }
      .compact
  end

  private_constant :MAXIMUM_QUANTITY
end
