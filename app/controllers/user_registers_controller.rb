# frozen_string_literal: true

# class responsible by control user registers
class UserRegistersController < ApplicationController
  def cities
    cities = State
             .find_by_name(params['state_name'])
             .cities
             .all
             .map(&:name)
             .sort

    render json: { 'cities' => cities }, status: :ok
  rescue StandardError => error
    Rails.logger.error("Message: #{error.message} - Backtrace: #{error.backtrace}")

    render json: { 'cities' => [] }, status: :internal_server_error
  end

  private

  def check_session_candidate_data
    raise SessionCandidateError unless session[:candidate_data]

  rescue SessionCandidateError => error
    Rails.logger.error("Message: #{error.message} - Backtrace: #{error.backtrace}")

    redirect_to registro_de_candidato_path
  end
end
