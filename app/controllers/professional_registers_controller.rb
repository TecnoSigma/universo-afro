# frozen_string_literal: true

# class responsible by control professional registers
class ProfessionalRegistersController < UserRegistersController
  before_action :check_session_user_data

  def index; end

  def create
    professional = Professional.new(professional_params)
    professional.validate!
    professional.save!

    redirect_to profissional_login_path
  rescue StandardError => error
    Rails.logger.error("Message: #{error.message} - Backtrace:#{error.backtrace}")

    redirect_to registro_do_profissional_path
  end

  private

  def personal_data_params
    { 'email' => session[:user_data]['email'],
      'password' => session[:user_data]['password'],
      'first_name' => session[:user_data]['first_name'],
      'last_name' => session[:user_data]['last_name'],
      'profession_id' => session[:user_data]['profession_id'],
      'cpf' => session[:user_data]['cpf'] }
  end

  def professional_params
    params
      .require(:professional)
      .permit(:postal_code, :address, :number, :complement, :district, :state, :city)
      .merge(personal_data_params)
  end
end
