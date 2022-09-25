# frozen_string_literal: true

# class responsible by control candidate registers
class VacantJobRegistersController < UserRegistersController
  before_action :check_session_user_data, :check_session_candidate_data
  before_action :check_first_vacant_job_data, only: [:second_vacant_job]

  def first_vacant_job; end
  def second_vacant_job; end

  def store_first_vacant_job_data
    session[:first_vacant_job] = { position: first_vacant_job_params[:position],
                                   kind: first_vacant_job_params[:kind],
                                   state: first_vacant_job_params[:state],
                                   city: first_vacant_job_params[:city],
                                   remote_job: first_vacant_job_params[:remote_job],
                                   alert: first_vacant_job_params[:alert]
    }

    redirect_to registro_de_vaga_2_path
  end

  def store_second_vacant_job_data
    session[:second_vacant_job] = { position: second_vacant_job_params[:position],
                                    kind: second_vacant_job_params[:kind],
                                    state: second_vacant_job_params[:state],
                                    city: second_vacant_job_params[:city],
                                    remote_job: second_vacant_job_params[:remote_job],
                                    alert: second_vacant_job_params[:alert]
    }

    redirect_to create_candidate_path
  end

  private

  def first_vacant_job_params
    params
      .require(:vacant_job_1)
      .permit(:position, :kind, :state, :city, :remote_job, :alert)
  end

  def second_vacant_job_params
    params
      .require(:vacant_job_2)
      .permit(:position, :kind, :state, :city, :remote_job, :alert)
  end

  def check_first_vacant_job_data
    raise SessionVerificationError unless session[:first_vacant_job]

  rescue SessionVerificationError => error
    Rails.logger.error("Message: #{error.message} - Backtrace: #{error.backtrace}")

    redirect_to registro_de_candidato_path
  end
end
