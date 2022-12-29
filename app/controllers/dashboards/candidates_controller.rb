# frozen_string_literal: true

module Dashboards
  # class responsible by manage candidates dashboard
  class CandidatesController < DashboardsController
    before_action :check_profile_session
    before_action :find_candidate
    before_action :update_vacant_job, only: %i[update_first_vacant_job_data update_second_vacant_job_data]

    def index; end
    def edit_profile; end
    def update_first_vacant_job_data; end
    def update_second_vacant_job_data; end

    def vacant_job_details
      @vacant_job = VacantJob.find_by(vacant_job_id: params['vacant_job_id'])
    end

    def apply
      candidature = Candidature.new(company_vacant_job: company_vacant_job, candidate_vacant_job: candidate_vacant_job)
      candidature.validate!
      candidature.save!

      redirect_to candidato_dashboard_path,
                  notice: I18n.t('messages.successes.candidature_at_vacant_job')
    rescue StandardError => e
      Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

      redirect_to candidato_dashboard_path, alert: I18n.t('messages.errors.candidature_at_vacant_job')
    end

    def update_personal_data
      @user.update!(first_name: candidate_params['first_name'], last_name: candidate_params['last_name'],
                    state: candidate_params['state'], city: candidate_params['city'],
                    ethnicity_self_declaration: candidate_params['ethnicity_self_declaration'])

      redirect_to candidato_dashboard_editar_perfil_path, notice: I18n.t('messages.successes.update_data')
    rescue StandardError => e
      treat_error(e)
    end

    def update_access_data
      raise PasswordConfirmationError unless candidate_params['password'] == candidate_params['confirm_password']
      raise StrongPasswordError unless User.strong_password?(candidate_params['password'])

      @user.update!(password: candidate_params['password'])

      redirect_to candidato_dashboard_editar_perfil_path, notice: I18n.t('messages.successes.update_data')
    rescue PasswordConfirmationError, StrongPasswordError, StandardError => e
      treat_error(e)
    end

    def update_avatar
      @user
        .avatar
        .attach(io: params['candidate']['avatar'],
                filename: Avatar::AVATAR_DEFAULT_NAME,
                content_type: 'image/png')

      @user.validate!
      @user.save

      redirect_to candidato_dashboard_editar_perfil_path, notice: I18n.t('messages.successes.update_data')
    rescue StandardError => e
      treat_error(e)
    end

    private

    def update_vacant_job
      vacant_job
        .update!(profession: profession, category: vacant_job_params['category'], state: vacant_job_params['state'],
                 city: vacant_job_params['city'], alert: alert, remote: remote)

      redirect_to candidato_dashboard_editar_perfil_path, notice: I18n.t('messages.successes.update_data')
    rescue StandardError => e
      treat_error(e)
    end

    def vacant_job
      @vacant_job ||= params['first_vacant_job'] ? @user.candidate_vacant_jobs.first : @user.candidate_vacant_jobs.last
    end

    def remote
      convert_to_bool(vacant_job_params['remote'])
    end

    def alert
      convert_to_bool(vacant_job_params['alert'])
    end

    def profession
      Profession.find_by(id: vacant_job_params['profession_id'])
    end

    def find_candidate
      @user = Candidate.find_by(afro_id: session[:afro_id])
    end

    def vacant_job_params
      @vacant_job_params ||= (params['first_vacant_job'] || params['second_vacant_job'])
    end

    def candidate_params
      @candidate_params ||= params['candidate']
    end

    def treat_error(error)
      Rails.logger.error("Message: #{error.message} - Backtrace: #{error.backtrace}")

      redirect_to candidato_dashboard_path, alert: I18n.t('messages.errors.update_data')
    end

    def candidate_vacant_job
      @user
        .candidate_vacant_jobs
        .detect { |vacant_job| vacant_job.profession.name == company_vacant_job.profession.name }
    end

    def company_vacant_job
      CompanyVacantJob.find_by(vacant_job_id: params['vacant_job']['id'])
    end
  end
end
