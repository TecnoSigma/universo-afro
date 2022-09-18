class ApplicationController < ActionController::Base
  private

  def clear_session(session_type = nil)
    session_type ? session_type = nil : reset_session
  end

  def check_recaptcha!
    verify_recaptcha! if Rails.env.production?
  rescue Recaptcha::VerifyError => error
    Rails.logger.error("Message: #{error.message} - Backtrace: #{error.backtrace}")

    clear_session

    redirect_to root_path
  end

  def check_session_user_data
    raise SessionVerificationError unless session[:user_data]

  rescue SessionVerificationError => error
    Rails.logger.error("Message: #{error.message} - Backtrace: #{error.backtrace}")

    redirect_to escolha_seu_perfil_path
  end
end
