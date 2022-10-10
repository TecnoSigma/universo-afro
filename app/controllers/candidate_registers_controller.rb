# frozen_string_literal: true

# class responsible by control candidate registers
class CandidateRegistersController < UserRegistersController
  before_action :check_session_user_data

  def index; end

  def store_candidate_data
    user_data = session[:user_data]
    candidate_data = candidate_params

    session[:candidate_data] = { email: user_data['email'],
                                 password: user_data['password'],
                                 first_name: candidate_data[:first_name],
                                 last_name: candidate_data[:last_name],
                                 state: candidate_data[:state],
                                 city: candidate_data[:city],
                                 ethnicity_self_declaration: candidate_data[:ethnicity_self_declaration] }

    redirect_to registro_da_vaga_1_path
  end

  def create
    candidate = Candidate.new(session[:candidate_data])
    candidate.validate!

    generate_vacant_jobs(candidate)

    redirect_to login_path
  rescue StandardError => e
    Rails.logger.error("Message: #{e.message} - Backtrace: #{e.backtrace}")

    redirect_to registro_do_candidato_path
  end

  private

  def generate_vacant_jobs(candidate)
    create_vacant_job!(candidate, session[:first_vacant_job])
    create_vacant_job!(candidate, session[:second_vacant_job])
  end

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
