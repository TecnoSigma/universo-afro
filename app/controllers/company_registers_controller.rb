# frozen_string_literal: true

# class responsible by control company registers
class CompanyRegistersController < UserRegistersController
  before_action :check_session_user_data

  def index; end

  def create
    company = Company.new(company_params)
    company.validate!
    company.save!

    redirect_to empresa_login_path
  rescue StandardError => e
    Rails.logger.error("Message: #{e.message} - Backtrace:#{e.backtrace}")

    redirect_to registro_da_empresa_path
  end

  private

  def personal_data_params
    user_data = session[:user_data]

    { 'email' => user_data['email'],
      'password' => user_data['password'],
      'name' => user_data['name'],
      'nickname' => user_data['nickname'],
      'cnpj' => user_data['cnpj'] }
  end

  def company_params
    params
      .require(:company)
      .permit(:postal_code, :address, :number, :complement, :district, :state, :city)
      .merge(personal_data_params)
  end
end
