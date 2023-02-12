# frozen_string_literal: true

module Dashboards
  # class responsible by manage conferences
  class ConferencesController < DashboardsController
    before_action :check_profile_session
    before_action :find_company

    def refuse
      conference.update!(refuse_data)

      redirect_to candidato_dashboard_path, notice: I18n.t('messages.successes.refused_conference')
    rescue StandardError => e
      Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

      redirect_to candidato_dashboard_path, alert: I18n.t('messages.errors.refusal_conference')
    end

    def accept
      ConferenceScheduleService.new(conference_afro_id: conference.afro_id).execute_actions

      redirect_to candidato_dashboard_path, notice: I18n.t('messages.successes.accepted_conference')
    rescue StandardError => e
      Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

      redirect_to candidato_dashboard_path, alert: I18n.t('messages.errors.acceptance_conference')
    end

    def create
      conference = Conference.new(conference_params)
      conference.validate!
      conference.save!

      redirect_to candidate_profile_path(url_resource),
                  notice: t('messages.successes.conference_creation')
    rescue StandardError => e
      Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

      redirect_to candidate_profile_path(url_resource),
                  alert: t('messages.errors.conference_creation')
    end

    private

    def candidate
      @candidate ||= Candidate.find_by_afro_id(params['conference']['candidate_afro_id'])
    end

    def url_resource
      @url_resource ||= candidate.fullname.to_resource
    end

    def conference_params
      params
        .require(:conference)
        .permit(:date, :horary)
        .merge({ 'candidate' => candidate, 'company' => find_company })
    end

    def conference
      @conference ||= Conference.find_by_afro_id(params[:conference_afro_id])
    end

    def refuse_data
      { date: converted_date(conference.start_at),
        horary: converted_horary(conference.start_at),
        reason: I18n.t('messages.informations.refused_by_candidate'),
        status: :refused }
    end
  end
end
