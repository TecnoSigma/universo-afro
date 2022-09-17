# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistersController, type: :request do
  describe 'GET actions' do
    describe '#inform_access_data' do
      it 'renders access data information page' do
        get '/informe-os-dados-de-usuario'

        expect(response).to render_template(:inform_user_data)
      end
    end

    describe '#choose_profile' do
      it 'renders profile choose page' do
        get '/escolha-seu-perfil'

        expect(response).to render_template(:choose_profile)
      end
    end
  end

  describe 'POST actions' do
    describe '#store_user_data' do
      context 'when password is valid' do
        it 'redirects to profile choose page' do
          post '/store_user_data',
            params: { user_data: { email: 'all@acme.com.br', password: '#*$*JJ#(23292' } }

          expect(response).to redirect_to(escolha_seu_perfil_path)
        end
      end

      context 'when password is invalid' do
        it 'redirects to profile choose page' do
          post '/store_user_data',
            params: { user_data: { email: 'all@acme.com.br', password: '123456' } }

          expect(response).to redirect_to(escolha_seu_perfil_path)
        end

        it 'show error message' do
          post '/store_user_data',
            params: { user_data: { email: 'all@acme.com.br', password: '123456' } }

          expect(flash[:alert]).to eq('Senha inválida! Digite uma senha mais forte.')
        end
      end
    end

    describe '#store_user_profile' do
      context 'when profile is company' do
        it 'redirects to page that the user inform your data' do
          post '/store_user_profile',
            params: { profile: 'company' }

          expect(response).to redirect_to(informe_os_dados_de_usuario_path)
        end
      end

      context 'when profile is candidate' do
        it 'redirects to page that the user inform your data' do
          post '/store_user_profile',
            params: { profile: 'candidate' }

          expect(response).to redirect_to(informe_os_dados_de_usuario_path)
        end
      end

      context 'when profile is professional' do
        it 'redirects to page that the user inform your data' do
          post '/store_user_profile',
            params: { profile: 'professional' }

          expect(response).to redirect_to(informe_os_dados_de_usuario_path)
        end
      end

      context 'when profile is invalid' do
        it 'redirects to profile choose page' do
          post '/store_user_profile',
            params: { profile: 'invalid_profile' }

          expect(response).to redirect_to(escolha_seu_perfil_path)
        end
      end
    end
  end
end
