# frozen_string_literal: true

module Dashboards
  # class responsible by manage candidates dashboard
  class CandidatesController < DashboardsController
    before_action :check_profile_session
    before_action :find_candidate

    def index; end

    def edit_profile; end

    def update_avatar
      @user
        .avatar
        .attach(io: params['candidate']['avatar'],
                    filename: Avatar::AVATAR_DEFAULT_NAME,
                    content_type: 'image/png')

      @user.validate!
      @user.save

      redirect_to candidato_dashboard_path, notice: I18n.t('messages.successes.update_data')
    rescue StandardError => error
      redirect_to candidato_dashboard_path, alert: I18n.t('messages.errors.update_data')
    end

    private

    def find_candidate
      @user = Candidate.find_by(afro_id: session[:afro_id])
    end
  end
end
