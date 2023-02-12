# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboards::ConferencesController, type: :request do
  before(:each) do
    user = FactoryBot.create(:company)

    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session) { { profile: 'company', user_email: user.email, afro_id: user.afro_id } }
  end

  describe 'PATCH actions' do
    describe '#refuse' do
      context 'when no occurs errors' do
        it 'updates conference status to refused' do
          candidate = FactoryBot.create(:candidate)
          company = FactoryBot.create(:company)
          conference = FactoryBot.create(:conference, :pendent, company: company, candidate: candidate, reason: nil)

          patch "/dashboard/conference/refuse/#{conference.afro_id}"

          result = Conference.find_by_afro_id(conference.afro_id).status

          expected_result = 'refused'

          expect(result).to eq(expected_result)
        end

        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)
          company = FactoryBot.create(:company)
          conference = FactoryBot.create(:conference, :pendent, company: company, candidate: candidate, reason: nil)

          patch "/dashboard/conference/refuse/#{conference.afro_id}"

          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows success message' do
          candidate = FactoryBot.create(:candidate)
          company = FactoryBot.create(:company)
          conference = FactoryBot.create(:conference, :pendent, company: company, candidate: candidate, reason: nil)

          binding.pry

          patch "/dashboard/conference/refuse/#{conference.afro_id}"

          expect(flash[:notice]).to eq('Entrevista recusada!')
        end
      end

      context 'when occurs errors' do
        it 'redirects to candidate dashboard' do
          patch '/dashboard/conference/accept/invalid_afro_id'

          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows error message' do
          patch '/dashboard/conference/refuse/invalid_afro_id'

          expect(flash[:alert]).to eq('Falha em recusar entrevista!')
        end
      end
    end

    describe '#accept' do
      context 'when no occurs errors' do
        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)
          company = FactoryBot.create(:company)
          conference = FactoryBot.create(:conference, :pendent, company: company, candidate: candidate)

          allow(ConferenceScheduleService)
            .to receive_message_chain(:new, :execute_actions) { true }

          patch "/dashboard/conference/accept/#{conference.afro_id}"

          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows success message' do
          candidate = FactoryBot.create(:candidate)
          company = FactoryBot.create(:company)
          conference = FactoryBot.create(:conference, :pendent, company: company, candidate: candidate)

          allow(ConferenceScheduleService)
            .to receive_message_chain(:new, :execute_actions) { true }

          patch "/dashboard/conference/accept/#{conference.afro_id}"

          expect(flash[:notice]).to eq('Entrevista aceita!')
        end
      end

      context 'when occurs errors' do
        it 'redirects to candidate dashboard' do
          patch '/dashboard/conference/accept/invalid_afro_id'

          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows error message' do
          patch '/dashboard/conference/accept/invalid_afro_id'

          expect(flash[:alert]).to eq('Falha em aceitar entrevista!')
        end
      end

      context 'when occurs errors in accept conference' do
        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)
          company = FactoryBot.create(:company)
          conference = FactoryBot.create(:conference, :pendent, company: company, candidate: candidate)

          allow(ConferenceScheduleService)
            .to receive_message_chain(:new, :execute_actions) { raise AASM::InvalidTransition }

          patch "/dashboard/conference/accept/#{conference.afro_id}"

          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows error message' do
          candidate = FactoryBot.create(:candidate)
          company = FactoryBot.create(:company)
          conference = FactoryBot.create(:conference, :pendent, company: company, candidate: candidate)

          allow(ConferenceScheduleService)
            .to receive_message_chain(:new, :execute_actions) { raise AASM::InvalidTransition }

          patch "/dashboard/conference/accept/#{conference.afro_id}"

          expect(flash[:alert]).to eq('Falha em aceitar entrevista!')
        end
      end
    end
  end

  describe 'POST actions' do
    describe '#create' do
      context 'when pass valid params' do
        it 'creates a new conference' do
          date = '12/12/2023'
          horary = '20:00'
          candidate = FactoryBot.create(:candidate)

          post '/dashboard/conference/create',
            params: { conference: { date: date, horary: horary, candidate_afro_id: candidate.afro_id } }

          result = Candidate.find_by_afro_id(candidate.afro_id).conferences

          expect(result).not_to be_empty
        end

        it 'redirects to candidate profile page in company dashboard' do
          date = '12/12/2023'
          horary = '20:00'
          candidate = FactoryBot.create(:candidate)

          post '/dashboard/conference/create',
            params: { conference: { date: date, horary: horary, candidate_afro_id: candidate.afro_id } }

          expect(response).to redirect_to(candidate_profile_path(candidate.fullname.to_resource))
        end

        it 'shows success message' do
          date = '12/12/2023'
          horary = '20:00'
          candidate = FactoryBot.create(:candidate)

          post '/dashboard/conference/create',
            params: { conference: { date: date, horary: horary, candidate_afro_id: candidate.afro_id } }

          expect(flash[:notice]).to eq('Entrevista criada com sucesso!')
        end
      end

      context 'when pass invalid params' do
        it 'no creates a new conference' do
          date = nil
          horary = '20:00'
          candidate = FactoryBot.create(:candidate)

          post '/dashboard/conference/create',
            params: { conference: { date: date, horary: horary, candidate_afro_id: candidate.afro_id } }

          result = Candidate.find_by_afro_id(candidate.afro_id).conferences

          expect(result).to be_empty
        end

        it 'redirects to candidate profile page in company dashboard' do
          date = nil
          horary = '20:00'
          candidate = FactoryBot.create(:candidate)

          post '/dashboard/conference/create',
            params: { conference: { date: date, horary: horary, candidate_afro_id: candidate.afro_id } }

          expect(response).to redirect_to(candidate_profile_path(candidate.fullname.to_resource))
        end

        it 'shows error message' do
          date = nil
          horary = '20:00'
          candidate = FactoryBot.create(:candidate)

          post '/dashboard/conference/create',
            params: { conference: { date: date, horary: horary, candidate_afro_id: candidate.afro_id } }

          expect(flash[:alert]).to eq('Erro ao criar entrevista!')
        end
      end
    end
  end
end
