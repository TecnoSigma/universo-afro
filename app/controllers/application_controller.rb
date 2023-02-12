# frozen_string_literal: true

# Class responsible by manage controllers
class ApplicationController < ActionController::Base
  skip_forgery_protection

  private

  def clear_session(session_type = nil)
    session_type ? session.delete(session_type) : reset_session
  end

  def check_recaptcha!
    verify_recaptcha! if Rails.env.production?
  rescue Recaptcha::VerifyError => e
    Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

    clear_session

    redirect_to root_path
  end

  def check_session_user_data
    raise SessionVerificationError unless session[:user_data]
  rescue SessionVerificationError => e
    Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

    redirect_to escolha_seu_perfil_path
  end

  def convert_to_bool(param)
    ActiveModel::Type::Boolean.new.cast(param)
  end

  def converted_date(datetime)
    datetime.strftime('%d/%m/%Y')
  end

  def converted_horary(datetime)
    datetime.strftime('%H:%M')
  end
end
