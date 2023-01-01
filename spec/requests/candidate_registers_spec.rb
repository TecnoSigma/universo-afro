# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CandidateRegistersController, type: :request do
  before(:each) do
    candidate_params = FactoryBot.attributes_for(:candidate)
    candidate_data = { first_name: candidate_params[:first_name],
                       last_name: candidate_params[:last_name],
                       email: candidate_params[:email],
                       password: candidate_params[:password],
                       state: candidate_params[:state],
                       city: candidate_params[:city] }

    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session) { { user_data: candidate_data } }
  end

  describe 'GET actions' do
    describe '#index' do
      it 'renders index page' do
        candidate_params = FactoryBot.attributes_for(:candidate)
        candidate_data = { first_name: candidate_params[:first_name],
                           last_name: candidate_params[:last_name],
                           email: candidate_params[:email],
                           password: candidate_params[:password],
                           state: candidate_params[:state],
                           city: candidate_params[:city] }

        allow_any_instance_of(ActionDispatch::Request)
          .to receive(:session) { { user_data: candidate_data } }

        get '/registro-do-candidato'

        expect(response).to render_template(:index)
      end
    end
  end

  describe 'POST actions' do
    describe '#store_candidate_data' do
      it 'redirects to first vacant job register page' do
        candidate_params = FactoryBot.attributes_for(:candidate).except(:afro_id)

        candidate_data = { first_name: candidate_params[:first_name],
                           last_name: candidate_params[:last_name],
                           email: candidate_params[:email],
                           password: candidate_params[:password],
                           state: candidate_params[:state],
                           city: candidate_params[:city] }

        allow_any_instance_of(ActionDispatch::Request)
          .to receive(:session) { { user_data: candidate_data } }

        post '/store_candidate_data',
          params: { candidate: candidate_params }

        expect(response).to redirect_to(registro_da_vaga_1_path)
      end
    end

    describe '#create_candidate' do
      context 'when pass valid params' do
        it 'creates new candidates with vacant jobs' do
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          first_vacant_job_params = FactoryBot.attributes_for(:vacant_job)
          second_vacant_job_params = FactoryBot.attributes_for(:vacant_job)
          candidate_params = FactoryBot.attributes_for(:candidate).except(:afro_id)

          candidate_data = { first_name: candidate_params[:first_name],
                             last_name: candidate_params[:last_name],
                             email: candidate_params[:email],
                             password: candidate_params[:password],
                             state: candidate_params[:state],
                             city: candidate_params[:city] }

          session_first_vacant_job = { profession_id: profession1.id,
                                       category: first_vacant_job_params[:category],
                                       state: first_vacant_job_params[:state],
                                       city: first_vacant_job_params[:city] }

          session_second_vacant_job = { profession_id: profession2.id,
                                        category: second_vacant_job_params[:category],
                                        state: second_vacant_job_params[:state],
                                        city: second_vacant_job_params[:city] }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) {  { candidate_data: candidate_data,
                                       user_data: candidate_data,
                                       first_vacant_job: session_first_vacant_job,
                                       second_vacant_job: session_second_vacant_job } }

          post '/create_candidate', params: { candidate: candidate_params }

          result1 = Candidate.find_by(first_name: candidate_params[:first_name])
          result2 = CandidateVacantJob.find_by(profession_id: profession1.id)
          result3 = CandidateVacantJob.find_by(profession_id: profession2.id)
          result4 = result1.status

          expect(result1).to be_present
          expect(result2).to be_present
          expect(result3).to be_present
          expect(result4).to eq('activated')
          expect(result1.candidate_vacant_jobs).to include(result2)
          expect(result1.candidate_vacant_jobs).to include(result3)
        end

        it 'redirects to candidate login page' do
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          first_vacant_job_params = FactoryBot.attributes_for(:vacant_job)
          second_vacant_job_params = FactoryBot.attributes_for(:vacant_job)
          candidate_params = FactoryBot.attributes_for(:candidate).except(:afro_id)

          candidate_data = { first_name: candidate_params[:first_name],
                             last_name: candidate_params[:last_name],
                             email: candidate_params[:email],
                             password: candidate_params[:password],
                             state: candidate_params[:state],
                             city: candidate_params[:city] }

          session_first_vacant_job = { profession_id: profession1.id,
                                       category: first_vacant_job_params[:category],
                                       state: first_vacant_job_params[:state],
                                       city: first_vacant_job_params[:city] }

          session_second_vacant_job = { profession_id: profession2.id,
                                        category: second_vacant_job_params[:category],
                                        state: second_vacant_job_params[:state],
                                        city: second_vacant_job_params[:city] }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) {  { candidate_data: candidate_data,
                                       user_data: candidate_data,
                                       first_vacant_job: session_first_vacant_job,
                                       second_vacant_job: session_second_vacant_job } }

          post '/create_candidate', params: { candidate: candidate_params }

          expect(response).to redirect_to(login_path)
        end
      end

      context 'when pass invalid params' do
        it 'no creates new candidates with vacant jobs' do
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          first_vacant_job_params = FactoryBot.attributes_for(:vacant_job)
          second_vacant_job_params = FactoryBot.attributes_for(:vacant_job)
          candidate_params = FactoryBot.attributes_for(:candidate).except(:afro_id)

          candidate_data = { first_name: '',
                             last_name: candidate_params[:last_name],
                             email: candidate_params[:email],
                             password: candidate_params[:password],
                             state: candidate_params[:state],
                             city: candidate_params[:city] }

          session_first_vacant_job = { profession_id: profession1.id,
                                       category: first_vacant_job_params[:category],
                                       state: first_vacant_job_params[:state],
                                       city: first_vacant_job_params[:city] }

          session_second_vacant_job = { profession_id: profession2.id,
                                        category: second_vacant_job_params[:category],
                                        state: second_vacant_job_params[:state],
                                        city: second_vacant_job_params[:city] }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) {  { candidate_data: candidate_data,
                                       user_data: candidate_data,
                                       first_vacant_job: session_first_vacant_job,
                                       second_vacant_job: session_second_vacant_job } }

          post '/create_candidate', params: { candidate: candidate_params }

          result1 = Candidate.find_by(first_name: candidate_params[:first_name])
          result2 = CandidateVacantJob.find_by(profession_id: profession1.id)
          result3 = CandidateVacantJob.find_by(profession_id: profession2.id)

          expect(result1).to be_nil
          expect(result2).to be_nil
          expect(result3).to be_nil
        end

        it 'redirects to candidate registers page' do
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          first_vacant_job_params = FactoryBot.attributes_for(:vacant_job)
          second_vacant_job_params = FactoryBot.attributes_for(:vacant_job)
          candidate_params = FactoryBot.attributes_for(:candidate).except(:afro_id)

          candidate_data = { first_name: '',
                             last_name: candidate_params[:last_name],
                             email: candidate_params[:email],
                             password: candidate_params[:password],
                             state: candidate_params[:state],
                             city: candidate_params[:city] }

          session_first_vacant_job = { profession_id: profession1.id,
                                       category: first_vacant_job_params[:category],
                                       state: first_vacant_job_params[:state],
                                       city: first_vacant_job_params[:city] }

          session_second_vacant_job = { profession_id: profession1.id,
                                        category: second_vacant_job_params[:category],
                                        state: second_vacant_job_params[:state],
                                        city: second_vacant_job_params[:city] }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) {  { candidate_data: candidate_data,
                                       user_data: candidate_data,
                                       first_vacant_job: session_first_vacant_job,
                                       second_vacant_job: session_second_vacant_job } }

          post '/create_candidate', params: { candidate: candidate_params }

          expect(response).to redirect_to(registro_do_candidato_path)
        end
      end
    end
  end
end
