# frozen_string_literal: true

# class responsible by control logins
class LoginsController < ApplicationController
  def index; end
  def send_password; end

  def send_password_notification
    raise FindActivatedUserError unless user
    raise NotifiedUserError unless sent_password?(user.password)

    redirect_to login_path, notice: I18n.t('messages.successes.sent_password')
  rescue FindActivatedUserError, NotifiedUserError => error
    redirect_to login_path, alert: error.message
  end

  private

  def sent_password?(password)
    Notifications::SendPassword
      .new(email: notifications_params[:email], password: password)
      .deliver!
  end

  def user
    @user ||= case notifications_params[:profile]
      when 'candidate';    then Candidate.find_by(email: notifications_params[:email], status: 'activated')
      when 'company';      then Company.find_by(email: notifications_params[:email], status: 'activated')
      when 'professional'; then Professional.find_by(email: notifications_params[:email], status: 'activated')
      else                 nil
      end
  end

  def notifications_params
    params.require(:user).permit(:profile, :email)
  end
end
