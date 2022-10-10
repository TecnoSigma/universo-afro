# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginsController, type: :request do
  describe 'GET actions' do
    describe '#index' do
      it 'renders login page' do
        get '/login'

        expect(response).to render_template(:index)
      end
    end

    describe '#send_password' do
      it 'renders sent password page' do
        get '/enviar_senha'

        expect(response).to render_template(:send_password)
      end
    end
  end

  describe 'POST actions' do
    describe '#send_password' do
      context 'when pass invalid profile' do
        it 'no sends user password notification' do
          expect(Notifications::SendPassword).not_to receive(:new)

          post '/send_password_notification',
               params: { user: { profile: 'invalid_profile', email: 'any_email' } }
        end

        it 'redirects to login page' do
          post '/send_password_notification',
               params: { user: { profile: 'invalid_profile', email: 'any_email' } }

          expect(response).to redirect_to(login_path)
        end

        it 'shows errors message' do
          post '/send_password_notification',
               params: { user: { profile: 'invalid_profile', email: 'any_email' } }

          expect(flash[:alert]).to eq('Usuário ativado não encontrado!')
        end
      end

      Profile::PROFILES.each do |profile|
        context "when pass valid email of activated #{profile}" do
          it 'sends user password notification' do
            if profile == 'professional'
              profession = FactoryBot.create(:profession)

              profile_data = FactoryBot.create(profile.to_sym, :activated, profession: profession)
            else
              profile_data = FactoryBot.create(profile.to_sym, :activated)
            end

            allow(Notifications::SendPassword).to receive_message_chain(:new, :deliver!) { true }

            expect(Notifications::SendPassword).to receive_message_chain(:new, :deliver!)

            post '/send_password_notification',
                 params: { user: { profile: profile, email: profile_data.email } }
          end

          it 'redirects to login page' do
            if profile == 'professional'
              profession = FactoryBot.create(:profession)

              profile_data = FactoryBot.create(profile.to_sym, :activated, profession: profession)
            else
              profile_data = FactoryBot.create(profile.to_sym, :activated)
            end

            allow(Notifications::SendPassword).to receive_message_chain(:new, :deliver!) { true }

            post '/send_password_notification',
                 params: { user: { profile: profile, email: profile_data.email } }

            expect(response).to redirect_to(login_path)
          end

          it 'shows success message' do
            if profile == 'professional'
              profession = FactoryBot.create(:profession)

              profile_data = FactoryBot.create(profile.to_sym, :activated, profession: profession)
            else
              profile_data = FactoryBot.create(profile.to_sym, :activated)
            end

            allow(Notifications::SendPassword).to receive_message_chain(:new, :deliver!) { true }

            post '/send_password_notification',
                 params: { user: { profile: profile, email: profile_data.email } }

            expect(flash[:notice]).to eq('Senha enviada com sucesso!')
          end
        end

        context "when pass invalid email of activated #{profile}" do
          it 'no sends user password notification' do
            expect(Notifications::SendPassword).not_to receive(:new)

            post '/send_password_notification',
                 params: { user: { profile: profile, email: 'invalid_email' } }
          end

          it 'redirects to login page' do
            post '/send_password_notification',
                 params: { user: { profile: profile, email: 'invalid_email' } }

            expect(response).to redirect_to(login_path)
          end

          it 'shows error message' do
            post '/send_password_notification',
                 params: { user: { profile: profile, email: 'invalid_email' } }

            expect(flash[:alert]).to eq('Usuário ativado não encontrado!')
          end
        end

        %w(pendent deactivated cancelled).each do |status|
          context "when pass valid email of #{status} #{profile}" do
            it 'no sends user password notification' do
              if profile == 'professional'
                profession = FactoryBot.create(:profession)

                profile_data = FactoryBot.create(profile.to_sym, status.to_sym, profession: profession)
              else
                profile_data = FactoryBot.create(profile.to_sym, status.to_sym)
              end

              expect(Notifications::SendPassword).not_to receive(:new)

              post '/send_password_notification',
                   params: { user: { profile: profile, email: profile_data.email } }
            end

            it 'redirects to login page' do
              if profile == 'professional'
                profession = FactoryBot.create(:profession)

                profile_data = FactoryBot.create(profile.to_sym, status.to_sym, profession: profession)
              else
                profile_data = FactoryBot.create(profile.to_sym, status.to_sym)
              end

              post '/send_password_notification',
                   params: { user: { profile: profile, email: profile_data.email } }

              expect(response).to redirect_to(login_path)
            end

            it 'shows error message' do
              if profile == 'professional'
                profession = FactoryBot.create(:profession)

                profile_data = FactoryBot.create(profile.to_sym, status.to_sym, profession: profession)
              else
                profile_data = FactoryBot.create(profile.to_sym, status.to_sym)
              end

              post '/send_password_notification',
                   params: { user: { profile: profile, email: profile_data.email } }

              expect(flash[:alert]).to eq('Usuário ativado não encontrado!')
            end
          end
        end
      end
    end
  end
end
