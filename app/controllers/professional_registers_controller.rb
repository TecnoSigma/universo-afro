# frozen_string_literal: true

# class responsible by control professional registers
class ProfessionalRegistersController < UserRegistersController
  before_action :check_session_user_data

  def index; end
end
