# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboards::Companies::CandidatesController, type: :request do
  before(:each) do
    user = FactoryBot.create(:company)

    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session) { { profile: 'company', user_email: user.email, afro_id: user.afro_id } }
  end

  describe 'GET actions' do
    describe '#profile' do
      context 'when pass valid candidate resource' do
        it 'renders candidate profile page' do
          candidate = FactoryBot.create(:candidate, status: 'activated')

          get "/empresa/dashboard/perfil-do-candidato/#{candidate.fullname.to_resource}"

          expect(response).to render_template(:profile)
        end
      end

      context 'when pass invalid candidate resource' do
        it 'redirects to company dashboard page' do
          get '/empresa/dashboard/perfil-do-candidato/invalid_afro_id'

          expect(response).to redirect_to(empresa_dashboard_path)
        end

        it 'shows error message' do
          get '/empresa/dashboard/perfil-do-candidato/invalid_afro_id'

          expect(flash[:alert]).to eq('Candidato não encontrado!')
        end
      end
    end
  end
end
