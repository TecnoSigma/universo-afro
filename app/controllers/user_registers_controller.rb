# frozen_string_literal: true

# class responsible by control user registers
class UserRegistersController < ApplicationController
  def cities
    cities = State.find_by(name: params['state_name']).cities_list

    render json: { 'cities' => cities }, status: :ok
  rescue StandardError => e
    Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

    render json: { 'cities' => [] }, status: :internal_server_error
  end

  def address
    address = AddressService.new(postal_code: params['postal_code']).call

    render json: { 'address' => address }, status: :ok
  rescue StandardError, HTTP::TimeoutError => e
    Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

    render json: { 'address' => {} }, status: :internal_server_error
  end

  private

  def check_session_candidate_data
    raise SessionCandidateError unless session[:candidate_data]
  rescue SessionCandidateError => e
    Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

    redirect_to registro_do_candidato_path
  end
end
