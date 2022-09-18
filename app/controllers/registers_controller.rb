# frozen_string_literal: true

# class responsible by control user registers
class RegistersController < ApplicationController
  before_action :clear_session, only: [:choose_profile]
  before_action :check_recaptcha!, except: [:choose_profile, :inform_user_data]

  def inform_user_data; end
  def choose_profile; end

  def store_user_profile
    raise ProfileValidationError unless User.allowed_profile?(profile_params)

    session[:profile] = profile_params

    redirect_to informe_os_dados_de_usuario_path
  rescue ProfileValidationError => e
    Rails.logger.error("Message: #{e.message}")

    redirect_to escolha_seu_perfil_path
  end

  def store_user_data
    raise PasswordValidationError unless User.strong_password?(user_params[:password])

    create_session

    redirect_to escolha_seu_perfil_path
  rescue PasswordValidationError => e
    flash[:alert] = e.message

    redirect_to escolha_seu_perfil_path
  end

  private

  def create_session
    session[:user_data] = {
      company_alias: user_params[:company_alias], company_name: user_params[:company_name],
      cnpj: user_params[:cnpj], first_name: user_params[:first_name],
      last_name: user_params[:last_name], email: user_params[:email],
      password: user_params[:password]
    }
  end

  def profile_params
    @profile_params ||= params['profile']
  end

  def user_params
    params
      .require(:user_data)
      .permit(:company_alias, :company_name, :cnpj, :cpf,
              :first_name, :last_name, :email, :password)
  end
end
