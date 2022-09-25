# frozen_string_literal: true

# class responsible by control user registers validation
class RegisterValidationsController < ApplicationController
  before_action :clear_session, only: [:choose_profile]
  before_action :check_session_user_data, only: [:confirm_email]
  before_action :check_recaptcha!, except: [:choose_profile, :inform_user_data]

  def inform_user_data; end
  def choose_profile; end
  def confirm_email; end

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

    send_email_verification_notification!

    redirect_to confirme_seu_email_path
  rescue PasswordValidationError => e
    flash[:alert] = e.message

    redirect_to escolha_seu_perfil_path
  end

  def resend_verification_code
    verification_code = User.verification_code

    if send_email_verification_notification!(verification_code: verification_code)
      session[:verification_code] = verification_code

      redirect_to confirme_seu_email_path
    end
  end

  def check_verification_code
    if session[:verification_code] == verification_code_params[:code]
      clear_session(session[:verification_code])

      redirect_to registro_de_candidato_path
    else
      redirect_to confirme_seu_email_path
    end
  end

  private

  def send_email_verification_notification!(verification_code: session[:verification_code])
   return unless session[:user_data]

    Notifications::Validations::CheckEmail
      .new(email: recipient_email, verification_code: verification_code)
      .deliver!
  end

  def recipient_email
    session[:user_data][:email] || session[:user_data]['email']
  end

  def create_session
    session[:user_data] = {
      company_alias: user_params[:company_alias], company_name: user_params[:company_name],
      cnpj: user_params[:cnpj], first_name: user_params[:first_name],
      last_name: user_params[:last_name], email: user_params[:email],
      password: user_params[:password]
    }

    session[:verification_code] = User.verification_code
  end

  def profile_params
    @profile_params ||= params['profile']
  end

  def verification_code_params
    params.require(:verification_code).permit(:code)
  end

  def user_params
    params
      .require(:user_data)
      .permit(:company_alias, :company_name, :cnpj, :cpf,
              :first_name, :last_name, :email, :password)
  end
end
