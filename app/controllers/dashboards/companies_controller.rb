# frozen_string_literal: true

module Dashboards
  # class responsible by manage companies dashboard
  class CompaniesController < DashboardsController
    before_action :check_profile_session

    def index; end
  end
end
