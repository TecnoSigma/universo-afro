# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegisterValidationsController, type: :request do
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

    describe '#confirm_email' do
      context 'when exists user data session' do
        it 'renders email confirmation page' do
          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { user_data: { any_data: 'anything' } } }

          get '/confirme-seu-email'

          expect(response).to render_template(:confirm_email)
        end
      end

      context 'when no exists user data session' do
        it 'redirect to choose profile page' do

          get '/confirme-seu-email'

          expect(response).to redirect_to(escolha_seu_perfil_path)
        end
      end
    end
  end

  describe 'POST actions' do
    describe '#store_user_data' do
      context 'when password is valid' do
        it 'redirects to email confirmation page' do
          allow(Notifications::CheckEmailJob).to receive(:perform_now) { true }

          post '/store_user_data',
            params: { user_data: { email: 'all@acme.com.br', password: '#*$*JJ#(23292' } }

          expect(response).to redirect_to(confirme_seu_email_path)
        end
      end

      context 'when password is invalid' do
        it 'redirects to profile choose page' do
          post '/store_user_data',
            params: { user_data: { email: 'all@acme.com.br', password: '123456' } }

          expect(response).to redirect_to(informe_os_dados_de_usuario_path)
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

    describe '#check_verification_code' do
      context 'when check is accepted' do
        context 'and profile is of a candidate' do
          it 'redirects to candidate register page' do
            code = '123456'
            allow_any_instance_of(ActionDispatch::Request)
              .to receive(:session) { { verification_code: code, profile: 'candidate' } }

            post '/check_verification_code',
              params: { verification_code: { code: code } }

            expect(response).to redirect_to(registro_do_candidato_path)
          end
        end

        context 'and profile is of a prifessional' do
          it 'redirects to professional register page' do
            code = '123456'
            allow_any_instance_of(ActionDispatch::Request)
              .to receive(:session) { { verification_code: code, profile: 'professional' } }

            post '/check_verification_code',
              params: { verification_code: { code: code } }

            expect(response).to redirect_to(registro_do_profissional_path)
          end
        end
      end

      context 'when check isn\'t accepted' do
        it 'redirects to email confirmation page' do
          code = '123456'
          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { verification_code: 'invalid_code' } }

          post '/check_verification_code',
            params: { verification_code: { code: code } }

          expect(response).to redirect_to(confirme_seu_email_path)
        end
      end
    end

    describe '#resend_verification_code' do
      it 'redirects to email confirmation page when notification is resent' do
        allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { user_data: { any_data: 'anything' } } }
        allow(Notifications::CheckEmailJob).to receive(:perform_now) { true }

        post '/resend_verification_code'

        expect(response).to redirect_to(confirme_seu_email_path)
      end

      it 'no redirects to email confirmation page when notification isn\'t resent' do
        allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { user_data: { any_data: 'anything' } } }
        allow(Notifications::CheckEmailJob).to receive(:perform_now) { false }

        post '/resend_verification_code'

        expect(response).to have_http_status(204)
      end
    end
  end
end
