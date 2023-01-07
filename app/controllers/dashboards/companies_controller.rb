# frozen_string_literal: true

module Dashboards
  # class responsible by manage companies dashboard
  class CompaniesController < DashboardsController
    before_action :check_profile_session
    before_action :find_company

    def index; end
  end
end
