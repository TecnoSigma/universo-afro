# frozen_string_literal: true

module Dashboards
  module Companies
    # class responsible by manage companies dashboard
    class CandidatesController < DashboardsController
      before_action :check_profile_session
      before_action :find_company

      def profile
        @candidate = Candidate.find_by_resource(params['candidate_name'])

        raise FindCandidateError unless @candidate
      rescue FindCandidateError => error
        redirect_to empresa_dashboard_path, alert: t('messages.errors.candidate_not_found')
      end
    end
  end
end
