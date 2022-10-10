# frozen_string_literal: true

# class responsible by control professional registers
class ProfessionalRegistersController < UserRegistersController
  before_action :check_session_user_data

  def index; end

  def create
    professional = Professional.new(professional_params)
    professional.validate!
    professional.save!

    redirect_to login_path
  rescue StandardError => e
    Rails.logger.error("Message: #{e.message} - Backtrace:#{e.backtrace}")

    redirect_to registro_do_profissional_path
  end

  private

  def personal_data_params
    user_data = session[:user_data]

    { 'email' => user_data['email'],
      'password' => user_data['password'],
      'first_name' => user_data['first_name'],
      'last_name' => user_data['last_name'],
      'profession_id' => user_data['profession_id'],
      'cpf' => user_data['cpf'] }
  end

  def professional_params
    params
      .require(:professional)
      .permit(:postal_code, :address, :number, :complement, :district, :state, :city)
      .merge(personal_data_params)
  end
end
