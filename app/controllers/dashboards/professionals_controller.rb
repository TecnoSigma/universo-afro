# frozen_string_literal: true

module Dashboards
  # class responsible by manage professionals dashboard
  class ProfessionalsController < DashboardsController
    before_action :check_profile_session

    def index; end
  end
end
