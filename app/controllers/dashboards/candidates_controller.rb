# frozen_string_literal: true

module Dashboards
  # class responsible by manage candidates dashboard
  class CandidatesController < DashboardsController
    before_action :check_profile_session

    def index
      @user = Candidate.find_by_email(session[:user_email])
    end
  end
end
