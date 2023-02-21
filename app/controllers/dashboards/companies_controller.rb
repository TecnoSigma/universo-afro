# frozen_string_literal: true

module Dashboards
  # class responsible by manage companies dashboard
  class CompaniesController < DashboardsController
    before_action :check_profile_session
    before_action :find_company

    def index; end
    def edit_profile; end

    def update_personal_data
      @company.update!(company_params)

      redirect_to empresa_dashboard_editar_perfil_path, notice: I18n.t('messages.successes.update_data')
    rescue StandardError => e
      treat_error(e)
    end

    def update_access_data
      raise PasswordConfirmationError unless company_params['password'] == company_params['confirm_password']
      raise StrongPasswordError unless User.strong_password?(company_params['password'])

      @company.update!(password: company_params['password'])

      redirect_to empresa_dashboard_editar_perfil_path, notice: I18n.t('messages.successes.update_data')
    rescue PasswordConfirmationError, StrongPasswordError, StandardError => e
      treat_error(e)
    end

    def update_avatar
      @company
        .avatar
        .attach(io: params['company']['avatar'],
                filename: Avatar::AVATAR_DEFAULT_NAME,
                content_type: 'image/png')

      @company.validate!
      @company.save

      redirect_to empresa_dashboard_editar_perfil_path, notice: I18n.t('messages.successes.update_data')
    rescue StandardError => e
      treat_error(e)
    end

    private

    def treat_error(error)
      Rails.logger.error("Message: #{error.message} - Backtrace: #{error.backtrace}")

      redirect_to empresa_dashboard_path, alert: I18n.t('messages.errors.update_data')
    end

    def company_params
      params
        .require(:company)
        .permit(:name, :nickname, :cnpj, :email, :address, :number,
                :complement, :district, :state, :city, :postal_code, :password, :confirm_password)
    end
  end
end
