# frozen_string_literal: true

# class responsible by manager candidatures
class Candidature < ApplicationRecord
  belongs_to :company_vacant_job
  belongs_to :candidate_vacant_job

  MAXIMUN_QUANTITY = 2

  def self.exceeded_quantity?(candidate)
    list(candidate).count >= MAXIMUN_QUANTITY
  end

  def self.list(candidate)
    candidate
      .candidate_vacant_jobs
      .inject([]) { |list, vacant_job| list << vacant_job.candidature }
      .compact
  end

  private_constant :MAXIMUN_QUANTITY
end
