# frozen_string_literal: true

# class responsible by control professional registers
class ProfessionalRegistersController < UserRegistersController
  before_action :check_session_user_data

  def index; end

  def store_professional_data
    session[:professional_data] = {
      email: session[:user_data]['email'],
      password: session[:user_data]['password'],
      first_name: session[:user_data][:first_name],
      last_name: session[:user_data][:last_name],
      profession_id: session[:user_data][:profession_id],
      cpf: session[:user_data][:cpf]
    }

    #redirect_to registro_de_vaga_1_path
  end
end
