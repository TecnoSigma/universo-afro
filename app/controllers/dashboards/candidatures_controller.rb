# frozen_string_literal: true

module Dashboards
  # class responsible by manage candidatures dashboard
  class CandidaturesController < DashboardsController
    before_action :check_profile_session
    before_action :find_candidate

    def cancel
      candidature = Candidature.find_by(id: params['candidature']['id'])
      candidature.delete

      redirect_to candidato_dashboard_path,
                  notice: I18n.t('messages.successes.candidature_cancelation')
    rescue StandardError => e
      Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

      redirect_to candidato_dashboard_path, alert: I18n.t('messages.errors.candidature_cancelation')
    end

    def apply
      candidature = Candidature.new(company_vacant_job: company_vacant_job, candidate_vacant_job: candidate_vacant_job)
      candidature.validate!
      candidature.save!

      redirect_to candidato_dashboard_path,
                  notice: I18n.t('messages.successes.candidature_at_vacant_job')
    rescue StandardError => e
      Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

      redirect_to candidato_dashboard_path, alert: I18n.t('messages.errors.candidature_at_vacant_job')
    end

    private

    def candidate_vacant_job
      @user
        .candidate_vacant_jobs
        .detect { |vacant_job| vacant_job.profession.name == company_vacant_job.profession.name }
    end

    def company_vacant_job
      CompanyVacantJob.find_by(vacant_job_id: params['vacant_job']['id'])
    end
  end
end
