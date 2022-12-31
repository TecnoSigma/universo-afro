# frozen_string_literal: true

# class responsible by manage dashboards
class DashboardsController < ApplicationController
  private

  def find_candidate
    @user = Candidate.find_by(afro_id: session[:afro_id])
  end

  def check_profile_session
    redirect_to login_path unless session[:profile]
  end
end
