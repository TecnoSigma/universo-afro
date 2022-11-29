# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboards::CandidatesController, type: :request do
  before(:each) do
    user = FactoryBot.create(:candidate)

    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session) { { profile: 'any_profile', user_email: user.email, afro_id: user.afro_id } }
  end

  describe 'GET actions' do
    describe '#index' do
      it 'renders candidates dashboard page' do
        get '/candidato/dashboard'

        expect(response).to render_template(:index)
      end
    end

    describe '#edit_profile' do
      it 'renders candidate edition page' do
        get '/candidato/dashboard/editar-perfil'

        expect(response).to render_template(:edit_profile)
      end
    end
  end

  describe 'PATCH actions' do
    describe '#update_avatar' do
      context 'when pass valid file' do
        it 'updates candidate avatar image' do
          user = Candidate.last

          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          patch '/candidato/dashboard/update-avatar', params: { candidate: { avatar: new_avatar } }

          result = user.avatar.attached?

          expect(result).to eq(true)
        end

        it 'redirects to candidate dashboard page' do
          user = Candidate.last

          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          patch '/candidato/dashboard/update-avatar', params: { candidate: { avatar: new_avatar } }

          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows success message' do
          user = Candidate.last

          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          patch '/candidato/dashboard/update-avatar', params: { candidate: { avatar: new_avatar } }

          expect(flash[:notice]).to eq('Dados atualizados com sucesso!')
        end
      end

      context 'when occurs errors' do
        it 'redirects to candidate dashboard page' do
          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          allow(Candidate).to receive_message_chain(:find_by, :avatar, :attach) { raise StandardError }

          patch '/candidato/dashboard/update-avatar', params: { candidate: { avatar: new_avatar } }

          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows error message' do
          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          allow(Candidate).to receive_message_chain(:find_by, :avatar, :attach) { raise StandardError }

          patch '/candidato/dashboard/update-avatar', params: { candidate: { avatar: new_avatar } }

          expect(flash[:alert]).to eq('Erro na atualização dos dados!')
        end
      end
    end
  end
end
