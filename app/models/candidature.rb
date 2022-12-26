class Candidature < ApplicationRecord
  has_many :company_vacant_jobs
  has_one :candidate_vacant_job
end
