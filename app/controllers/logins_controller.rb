# frozen_string_literal: true

# class responsible by control logins
class LoginsController < ApplicationController
  def index; end
  def send_password; end

  def send_password_notification
    raise FindActivatedUserError unless user
    raise NotifiedUserError unless sent_password?(user.password)

    redirect_to login_path, notice: I18n.t('messages.successes.sent_password')
  rescue FindActivatedUserError, NotifiedUserError => e
    redirect_to login_path, alert: e.message
  end

  def validate_access
    raise FindUserError unless user_data
    raise AuthorizedUserError unless user_data.activated?

    create_session!

    redirect_to "/#{translated_profile}/dashboard"
  rescue FindUserError, AuthorizedUserError => e
    Rails.logger.error("Message: #{error_access_message(e)} - Backtrace: #{e.backtrace}")

    redirect_to login_path, alert: error_access_message(e)
  end

  private

  def error_access_message(error)
    @error_access_message ||= case error
                              when FindUserError then I18n.t('messages.errors.user_not_found')
                              when AuthorizedUserError then I18n.t('messages.errors.access_not_authorized')
                              end
    error.message
  end

  def create_session!
    session[:profile] = user_params[:profile]
    session[:user_email] = user_data[:email]
  end

  def translated_profile
    I18n.t("routes.#{session[:profile]}")
  end

  def sent_password?(password)
    Notifications::SendPasswordService
      .new(email: notifications_params[:email], password: password)
      .deliver!
  end

  def user
    @user ||= case notifications_params[:profile]
              when 'candidate';    then Candidate.find_by(email: notifications_params[:email], status: 'activated')
              when 'company';      then Company.find_by(email: notifications_params[:email], status: 'activated')
              when 'professional'; then Professional.find_by(email: notifications_params[:email], status: 'activated')
              end
  end

  def user_data
    @user_data ||= case user_params[:profile]
                   when 'candidate'    then find_profile(Candidate)
                   when 'company'      then find_profile(Company)
                   when 'professional' then find_profile(Professional)
                   end
  end

  def user_params
    params.require(:user).permit(:profile, :email, :password)
  end

  def notifications_params
    params.require(:user).permit(:profile, :email)
  end

  def find_profile(klass)
    profile = klass.find_by(email: user_params[:email], password: user_params[:password])

    session[:afro_id] = profile.try(:afro_id)

    profile
  end
end
