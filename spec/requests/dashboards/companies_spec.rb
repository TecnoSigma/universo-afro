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

    describe '#edit_profile' do
      it 'renders page edition page' do
        get '/empresa/dashboard/editar-perfil'

        expect(response).to render_template(:edit_profile)
      end
    end
  end

  describe 'PATCH actions' do
    describe '#update_personal_data' do
      context 'when pass valid params' do
        it 'updates personal data' do
          company = FactoryBot.create(:company, number: 100)

          new_number = '999'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-personal-data',
            params: { company: { name: company.name,
                                 nickname: company.nickname,
                                 cnpj: company.cnpj,
                                 email: company.email,
                                 address: company.address,
                                 number: new_number,
                                 complement: company.complement,
                                 district: company.district,
                                 state: company.state,
                                 city: company.city,
                                 postal_code: company.postal_code } }

          result = Company.find_by_afro_id(company.afro_id).number

          expect(result).to eq(new_number)
        end

        it 'shows success message' do
          company = FactoryBot.create(:company, number: 100)

          new_number = '999'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-personal-data',
            params: { company: { name: company.name,
                                 nickname: company.nickname,
                                 cnpj: company.cnpj,
                                 email: company.email,
                                 address: company.address,
                                 number: new_number,
                                 complement: company.complement,
                                 district: company.district,
                                 state: company.state,
                                 city: company.city,
                                 postal_code: company.postal_code } }

          expect(flash[:notice]).to eq('Dados atualizados com sucesso!')
        end

        it 'redirects to company profile dashboard' do
          company = FactoryBot.create(:company, number: 100)

          new_number = '999'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-personal-data',
            params: { company: { name: company.name,
                                 nickname: company.nickname,
                                 cnpj: company.cnpj,
                                 email: company.email,
                                 address: company.address,
                                 number: new_number,
                                 complement: company.complement,
                                 district: company.district,
                                 state: company.state,
                                 city: company.city,
                                 postal_code: company.postal_code } }

          expect(response).to redirect_to(empresa_dashboard_editar_perfil_path)
        end
      end

      context 'when pass invalid params' do
        it 'no updates personal data' do
          new_cnpj = '12.345.678/0001-99'
          company = FactoryBot.create(:company)

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-personal-data',
            params: { company: { name: nil,
                                 nickname: company.nickname,
                                 cnpj: new_cnpj,
                                 email: company.email,
                                 address: company.address,
                                 number: company.number,
                                 complement: company.complement,
                                 district: company.district,
                                 state: company.state,
                                 city: company.city,
                                 postal_code: company.postal_code } }

          result = Company.find_by_afro_id(company.afro_id).cnpj

          expect(result).not_to eq(new_cnpj)
        end

        it 'shows errors message' do
          company = FactoryBot.create(:company)

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-personal-data',
            params: { company: { name: company.name,
                                 nickname: company.nickname,
                                 cnpj: nil,
                                 email: company.email,
                                 address: company.address,
                                 number: company.number,
                                 complement: company.complement,
                                 district: company.district,
                                 state: company.state,
                                 city: company.city,
                                 postal_code: company.postal_code } }

          expect(flash[:alert]).to eq('Erro na atualização dos dados!')
        end

        it 'redirects to company dashboard' do
          company = FactoryBot.create(:company)

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-personal-data',
            params: { company: { name: company.name,
                                 nickname: company.nickname,
                                 cnpj: nil,
                                 email: company.email,
                                 address: company.address,
                                 number: company.number,
                                 complement: company.complement,
                                 district: company.district,
                                 state: company.state,
                                 city: company.city,
                                 postal_code: company.postal_code } }

          expect(response).to redirect_to(empresa_dashboard_path)
        end
      end
    end

    describe '#update_avatar' do
      context 'when pass valid file' do
        it 'updates company avatar image' do
          user = Company.last

          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          patch '/empresa/dashboard/update-avatar', params: { company: { avatar: new_avatar } }

          result = user.avatar.attached?

          expect(result).to eq(true)
        end

        it 'redirects to company profile dashboard' do
          user = Company.last

          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          patch '/empresa/dashboard/update-avatar', params: { company: { avatar: new_avatar } }

          expect(response).to redirect_to(empresa_dashboard_editar_perfil_path)
        end

        it 'shows success message' do
          user = Company.last

          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          patch '/empresa/dashboard/update-avatar', params: { company: { avatar: new_avatar } }

          expect(flash[:notice]).to eq('Dados atualizados com sucesso!')
        end
      end

      context 'when occurs errors' do
        it 'redirects to company dashboard page' do
          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          allow(Company).to receive_message_chain(:find_by, :avatar, :attach) { raise StandardError }

          patch '/empresa/dashboard/update-avatar', params: { company: { avatar: new_avatar } }

          expect(response).to redirect_to(empresa_dashboard_path)
        end

        it 'shows error message' do
          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          allow(Company).to receive_message_chain(:find_by, :avatar, :attach) { raise StandardError }

          patch '/empresa/dashboard/update-avatar', params: { company: { avatar: new_avatar } }

          expect(flash[:alert]).to eq('Erro na atualização dos dados!')
        end
      end
    end

    describe '#update_access_data' do
      context 'when pass valid params' do
        it 'updates company password' do
          company = FactoryBot.create(:company)

          new_password = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-access-data',
            params: { company: { password: new_password, confirm_password: new_password } }

          result = Company.find_by_afro_id(company.afro_id).password

          expect(result).to eq(new_password)
        end

        it 'shows success message' do
          company = FactoryBot.create(:company)

          new_password = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-access-data',
            params: { company: { password: new_password, confirm_password: new_password } }

          expect(flash[:notice]).to eq('Dados atualizados com sucesso!')
        end

        it 'redirects to company profile dashboard' do
          company = FactoryBot.create(:company)

          new_password = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-access-data',
            params: { company: { password: new_password, confirm_password: new_password } }

          expect(response).to redirect_to(empresa_dashboard_editar_perfil_path)
        end
      end

      context 'when pass invalid params' do
        it 'no updates company password' do
          company = FactoryBot.create(:company)

          new_password = 'test1234'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-access-data',
            params: { company: { password: new_password, confirm_password: new_password } }

          result = Company.find_by_afro_id(company.afro_id).password

          expect(result).not_to eq(new_password)
        end

        it 'shows error message' do
          company = FactoryBot.create(:company)

          new_password = 'test1234'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-access-data',
            params: { company: { password: new_password, confirm_password: new_password } }

          expect(flash[:alert]).to eq('Erro na atualização dos dados!')
        end

        it 'redirects to company dashboard' do
          company = FactoryBot.create(:company)

          new_password = 'test1234'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-access-data',
            params: { company: { password: new_password, confirm_password: new_password } }

          expect(response).to redirect_to(empresa_dashboard_path)
        end
      end

      context 'when pass invalid password confirmation' do
        it 'no updates company password' do
          company = FactoryBot.create(:company)

          new_password1 = SecureRandom.hex
          new_password2 = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-access-data',
            params: { company: { password: new_password1, confirm_password: new_password2 } }

          result = Company.find_by_afro_id(company.afro_id).password

          expect(result).not_to eq(new_password1)
        end

        it 'shows error message' do
          company = FactoryBot.create(:company)

          new_password1 = SecureRandom.hex
          new_password2 = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-access-data',
            params: { company: { password: new_password1, confirm_password: new_password2 } }

          expect(flash[:alert]).to eq('Erro na atualização dos dados!')
        end

        it 'redirects to company dashboard' do
          company = FactoryBot.create(:company)

          new_password1 = SecureRandom.hex
          new_password2 = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'company', afro_id: company.afro_id } }

          patch '/empresa/dashboard/update-access-data',
            params: { company: { password: new_password1, confirm_password: new_password2 } }

          expect(response).to redirect_to(empresa_dashboard_path)
        end
      end
    end
  end
end
