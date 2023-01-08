# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboards::CompaniesController, type: :request do
  before(:each) do
    user = FactoryBot.create(:company)

    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session) { { profile: 'company', user_email: user.email, afro_id: user.afro_id } }
  end

  describe 'GET actions' do
    describe '#index' do
      it 'renders companies dashboard page' do
        get '/empresa/dashboard'

        expect(response).to render_template(:index)
      end
    end

    describe '#new' do
      it 'renders new vacant job page' do
        get '/empresa/dashboard/nova-vaga'

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST actions' do
    describe '#create_vacant_job' do
      context 'when pass valid params' do
        it 'creates a new comoany vacant job' do
          profession = FactoryBot.create(:profession)
          category = 'Meio período'

          post '/empresa/dashboard/create-vacant-job',
            params: { vacant_job: { profession: profession.name,
                                    category: category,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: 'Espírito Santo',
                                    city: 'Baixo Guandu' } }

          result = CompanyVacantJob.find_by_category(category)

          expect(result).to be_present
        end

        it 'redirects to company dashboard' do
          profession = FactoryBot.create(:profession)
          category = 'Meio período'

          post '/empresa/dashboard/create-vacant-job',
            params: { vacant_job: { profession: profession.name,
                                    category: category,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: 'Espírito Santo',
                                    city: 'Baixo Guandu' } }

          expect(response).to redirect_to(empresa_dashboard_path)
        end

        it 'shows success message' do
          profession = FactoryBot.create(:profession)
          category = 'Meio período'

          post '/empresa/dashboard/create-vacant-job',
            params: { vacant_job: { profession: profession.name,
                                    category: category,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: 'Espírito Santo',
                                    city: 'Baixo Guandu' } }

          expect(flash[:notice]).to eq('Vaga criada com sucesso!')
        end
      end

      context 'when pass invalid params' do
        it 'no creates a new comoany vacant job' do
          profession = FactoryBot.create(:profession)
          state = 'São Paulo'

          post '/empresa/dashboard/create-vacant-job',
            params: { vacant_job: { profession: profession.name,
                                    category: nil,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: state,
                                    city: 'Baixo Guandu' } }

          result = CompanyVacantJob.find_by_state(state)

          expect(result).to be_nil
        end

        it 'redirects to new vacant job dashboard' do
          profession = FactoryBot.create(:profession)

          post '/empresa/dashboard/create-vacant-job',
            params: { vacant_job: { profession: profession.name,
                                    category: nil,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: 'Espírito Santo',
                                    city: 'Baixo Guandu' } }

          expect(response).to redirect_to(empresa_dashboard_nova_vaga_path)
        end

        it 'shows error message' do
          profession = FactoryBot.create(:profession)

          post '/empresa/dashboard/create-vacant-job',
            params: { vacant_job: { profession: profession.name,
                                    category: nil,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: 'Espírito Santo',
                                    city: 'Baixo Guandu' } }

          expect(flash[:alert]).to eq('Erro na criação de nova vaga!')
        end
      end
    end
  end
end
