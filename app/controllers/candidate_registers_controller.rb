# frozen_string_literal: true

# class responsible by control candidate registers
class CandidateRegistersController < UserRegistersController
  before_action :check_session_user_data

  def index; end

  def store_candidate_data
    session[:candidate_data] = {
      email: session[:user_data]['email'],
      password: session[:user_data]['password'],
      first_name: candidate_params[:first_name],
      last_name: candidate_params[:last_name],
      state: candidate_params[:state],
      city: candidate_params[:city],
      ethnicity_self_declaration: candidate_params[:ethnicity_self_declaration]
    }

    redirect_to registro_de_vaga_1_path
  end

  def create
    candidate = Candidate.new(session[:candidate_data])
    candidate.validate!

    create_vacant_job!(candidate, session[:first_vacant_job])
    create_vacant_job!(candidate, session[:second_vacant_job])

    redirect_to candidato_login_path
  rescue StandardError => error
    Rails.logger.error("Message: #{error.message} - Backtrace: #{error.backtrace}")

    redirect_to registro_de_candidato_path
  end

  private

  def create_vacant_job!(candidate, vacant_job)
    vacant_job = CandidateVacantJob.new(vacant_job)
    vacant_job.candidate = candidate

    vacant_job.validate!
    vacant_job.save!
  end

  def candidate_params
    params
      .require(:candidate)
      .permit(:first_name, :last_name, :state, :city, :ethnicity_self_declaration)
  end
end
