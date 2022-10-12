# frozen_string_literal: true

# class responsible by manage dashboards
class DashboardsController < ApplicationController
  private

  def check_profile_session
    redirect_to login_path unless session[:profile]
  end
end
