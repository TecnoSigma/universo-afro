# frozen_string_literal: true

class Candidature < ApplicationRecord
  belongs_to :company_vacant_job
  belongs_to :candidate_vacant_job
end
