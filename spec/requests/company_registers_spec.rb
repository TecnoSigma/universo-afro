# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompanyRegistersController, type: :request do
  describe 'GET actions' do
    describe '#index' do
      it 'renders index page' do
        company_params = FactoryBot.attributes_for(:company)
        company_data = { 'name' => company_params[:name],
                         'nickname' => company_params[:nickname],
                         'cnpj' => company_params[:cnpj],
                         'email' => company_params[:email],
                         'password' => company_params[:password] }

        allow_any_instance_of(ActionDispatch::Request)
          .to receive(:session) { { user_data: company_data } }

        get '/registro-da-empresa'

        expect(response).to render_template(:index)
      end
    end
  end

  describe 'POST actions' do
    describe '#create' do
      context 'when pass valid params' do
        it 'creates new company' do
          company_params = FactoryBot.attributes_for(:company)
          company_data = { 'name' => company_params[:name],
                           'nickname' => company_params[:nickname],
                           'cnpj' => company_params[:cnpj],
                           'email' => company_params[:email],
                           'password' => company_params[:password] }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { user_data: company_data } }

          post '/create_company', params: {
            company: { postal_code: company_params[:postal_code],
                       address: company_params[:address],
                       number: company_params[:number],
                       complement: company_params[:complement],
                       district: company_params[:district],
                       state: company_params[:state],
                       city: company_params[:city] }
          }

          result = Company.find_by(name: company_params[:name])

          expect(result).to be_present
        end

        it 'redirects to company login page' do
          company_params = FactoryBot.attributes_for(:company)
          company_data = { 'name' => company_params[:name],
                           'nickname' => company_params[:nickname],
                           'cnpj' => company_params[:cnpj],
                           'email' => company_params[:email],
                           'password' => company_params[:password] }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { user_data: company_data } }

          post '/create_company', params: {
            company: { postal_code: company_params[:postal_code],
                       address: company_params[:address],
                       number: company_params[:number],
                       complement: company_params[:complement],
                       district: company_params[:district],
                       state: company_params[:state],
                       city: company_params[:city] }
          }

          expect(response).to redirect_to(empresa_login_path)
        end
      end

      context 'when pass invalid params' do
        it 'no creates new company' do
          company_params = FactoryBot.attributes_for(:company)
          company_data = { 'name' => company_params[:name],
                           'nickname' => company_params[:nickname],
                           'cnpj' => company_params[:cnpj],
                           'email' => company_params[:email],
                           'password' => company_params[:password] }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { user_data: company_data } }

          post '/create_company', params: {
            company: { postal_code: company_params[:postal_code],
                       address: company_params[:address],
                       number: company_params[:number],
                       complement: company_params[:complement],
                       district: company_params[:district],
                       state: nil,
                       city: company_params[:city] }
          }

          result = Company.find_by(name: company_params[:name])

          expect(result).to be_nil
        end

        it 'redirects to company register page' do
          company_params = FactoryBot.attributes_for(:company)
          company_data = { 'name' => company_params[:name],
                           'nickname' => company_params[:nickname],
                           'cnpj' => company_params[:cnpj],
                           'email' => company_params[:email],
                           'password' => company_params[:password] }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { user_data: company_data } }

          post '/create_company', params: {
            company: { postal_code: company_params[:postal_code],
                       address: company_params[:address],
                       number: company_params[:number],
                       complement: company_params[:complement],
                       district: company_params[:district],
                       state: nil,
                       city: company_params[:city] }
          }

          expect(response).to redirect_to(registro_da_empresa_path)
        end
      end
    end
  end
end
