# frozen_string_literal: true

module Dashboards
  module Companies
    # class responsible by manage companies vacant job dashboard
    class VacantJobsController < DashboardsController
      before_action :check_profile_session
      before_action :find_company
      before_action :find_vacant_job, only: [:edit]

      def new; end
      def edit; end

      def create
        vacant_job = CompanyVacantJob.new(params_vacant_job)
        vacant_job.validate!
        vacant_job.save!

        redirect_to empresa_dashboard_path, notice: t('messages.successes.vacant_job_creation')
      rescue StandardError => e
        Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

        redirect_to empresa_dashboard_vaga_nova_vaga_path, alert: t('messages.errors.vacant_job_creation')
      end

      private

      def profession
        Profession.find_by_name(params['vacant_job']['profession'])
      end

      def params_vacant_job
        params[:vacant_job]
          .permit(:category, :availabled_quantity, :details, :remote, :state, :city)
          .merge({ 'profession' => profession, 'company' => @company })
      end

      def find_vacant_job
        @vacant_job = CompanyVacantJob.find_by_vacant_job_id(params['vacant_job_id'])
      end
    end
  end
end
