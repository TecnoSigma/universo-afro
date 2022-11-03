# frozen_string_literal: true

# class responsible by fill vacant jobs
class VacantJobFill
  include AASM

  aasm do
    state :updated_vacant_job_availabled_quantity, initial: true
    state :updated_vacant_job_filled_quantity
    state :updated_company_vacant_job_status
    state :updated_candidate_vacant_job_status
    state :finished

    event :update_vacant_job_availabled_quantity do
      transitions from: :updated_vacant_job_availabled_quantity,
                  to: :updated_vacant_job_filled_quantity,
                  if: :update_vacant_job_availabled_quantity!
    end

    event :update_vacant_job_filled_quantity do
      transitions from: :updated_vacant_job_filled_quantity,
                  to: :updated_company_vacant_job_status,
                  if: :update_vacant_job_filled_quantity!
    end

    event :update_company_vacant_job_status do
      transitions from: :updated_company_vacant_job_status,
                  to: :updated_candidate_vacant_job_status,
                  if: :update_company_vacant_job_status!
    end

    event :update_candidate_vacant_job_status do
      transitions from: :updated_candidate_vacant_job_status,
                  to: :finished,
                  if: :update_candidate_vacant_job_status!
    end
  end

  attr_reader :company_vacant_job_id, :candidate_vacant_job_id

  def initialize(company_vacant_job_id:, candidate_vacant_job_id:)
    @company_vacant_job_id = company_vacant_job_id
    @candidate_vacant_job_id = candidate_vacant_job_id
  end

  def call
    run_actions
  rescue AASM::InvalidTransition => e
    Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

    false
  end

  private

  def run_actions
    update_vacant_job_availabled_quantity if updated_vacant_job_availabled_quantity?
    update_vacant_job_filled_quantity     if updated_vacant_job_filled_quantity?
    update_company_vacant_job_status      if updated_company_vacant_job_status?
    update_candidate_vacant_job_status    if updated_candidate_vacant_job_status?
  end

  def update_vacant_job_availabled_quantity!
    company_vacant_job.update!(availabled_quantity: updated_availabled_quantity)
  end

  def update_vacant_job_filled_quantity!
    company_vacant_job.update!(filled_quantity: updated_filled_quantity)
  end

  def update_company_vacant_job_status!
    return true unless company_vacant_job.availabled_quantity.zero?

    company_vacant_job.update!(status: 'closed')
  end

  def update_candidate_vacant_job_status!
    candidate_vacant_job.update!(status: 'closed')
  end

  def updated_availabled_quantity
    company_vacant_job.availabled_quantity - 1
  end

  def updated_filled_quantity
    company_vacant_job.filled_quantity + 1
  end

  def candidate_vacant_job
    @candidate_vacant_job = CandidateVacantJob.find_by(id: candidate_vacant_job_id)
  end

  def company_vacant_job
    @company_vacant_job = ::CompanyVacantJob.find_by(id: company_vacant_job_id)
  end
end
