# frozen_string_literal: true

# class responsible by control user registers validation
class RegisterValidationsController < ApplicationController
  before_action :clear_session, only: [:choose_profile]
  before_action :check_session_user_data, only: [:confirm_email]
  before_action :check_recaptcha!, except: %i[choose_profile inform_user_data]

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

    redirect_to informe_os_dados_de_usuario_path, alert: e.message
  end

  def resend_verification_code
    verification_code = User.verification_code

    return unless send_email_verification_notification!(verification_code: verification_code)

    session[:verification_code] = verification_code

    redirect_to confirme_seu_email_path
  end

  def check_verification_code
    if session[:verification_code] == verification_code_params[:code]
      clear_session(session[:verification_code])

      redirect_to_register_page
    else
      redirect_to confirme_seu_email_path
    end
  end

  private

  def redirect_to_register_page
    case session[:profile]
    when 'candidate'
      redirect_to registro_do_candidato_path
    when 'professional'
      redirect_to registro_do_profissional_path
    when 'company'
      redirect_to registro_da_empresa_path
    end
  end

  def send_email_verification_notification!(verification_code: session[:verification_code])
    return unless session[:user_data]

    Notifications::CheckEmailJob
      .perform_now(name: session[:user_data][:name] || session[:user_data][:first_name],
                   email: recipient_email,
                   verification_code: verification_code)
  end

  def recipient_email
    session[:user_data][:email] || session[:user_data]['email']
  end

  def create_session
    session[:user_data] = user_data
    session[:verification_code] = User.verification_code
  end

  def user_data
    user = user_params

    { name: user[:name], nickname: user[:nickname], cnpj: user[:cnpj], cpf: user[:cpf],
      first_name: user[:first_name], last_name: user[:last_name], email: user[:email], password: user[:password],
      profession_id: user[:profession_id] }
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
      .permit(:name, :nickname, :cnpj, :cpf, :profession_id,
              :first_name, :last_name, :email, :password)
  end
end
