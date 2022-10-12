# frozen_string_literal: true

module Dashboards
  # class responsible by manage candidates dashboard
  class CandidatesController < DashboardsController
    before_action :check_profile_session

    def index; end
  end
end
