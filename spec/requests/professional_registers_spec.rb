# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfessionalRegistersController, type: :request do
  describe 'GET actions' do
    describe '#index' do
      it 'renders index page' do
        profession = FactoryBot.create(:profession)
        professional_params = FactoryBot.attributes_for(:professional)
        professional_data = { first_name: professional_params[:first_name],
                              last_name: professional_params[:last_name],
                              cpf: professional_params[:cpf],
                              email: professional_params[:email],
                              password: professional_params[:password],
                              profession_id: profession.id }

        allow_any_instance_of(ActionDispatch::Request)
          .to receive(:session) { { user_data: professional_data } }

        get '/registro-do-profissional'

        expect(response).to render_template(:index)
      end
    end
  end

  describe 'POST actions' do
    describe '#create' do
      context 'when pass valid params' do
        it 'creates new professional' do
          profession = FactoryBot.create(:profession)
          professional_params = FactoryBot.attributes_for(:professional)
          professional_data = { 'first_name' => professional_params[:first_name],
                                'last_name' => professional_params[:last_name],
                                'cpf' => professional_params[:cpf],
                                'email' => professional_params[:email],
                                'password' => professional_params[:password],
                                'profession_id' => profession.id }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { user_data: professional_data } }

          post '/create_professional', params: {
            professional: { postal_code: professional_params[:postal_code],
                            address:professional_params[:address],
                            number: professional_params[:number],
                            complement: professional_params[:complement],
                            district: professional_params[:district],
                            state: professional_params[:state],
                            city: professional_params[:city] }
          }

          result = Professional.find_by(first_name: professional_params[:first_name])

          expect(result).to be_present
        end

        it 'redirects to professional login page' do
          profession = FactoryBot.create(:profession)
          professional_params = FactoryBot.attributes_for(:professional)
          professional_data = { 'first_name' => professional_params[:first_name],
                                'last_name' => professional_params[:last_name],
                                'cpf' => professional_params[:cpf],
                                'email' => professional_params[:email],
                                'password' => professional_params[:password],
                                'profession_id' => profession.id }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { user_data: professional_data } }

          post '/create_professional', params: {
            professional: { postal_code: professional_params[:postal_code],
                            address:professional_params[:address],
                            number: professional_params[:number],
                            complement: professional_params[:complement],
                            district: professional_params[:district],
                            state: professional_params[:state],
                            city: professional_params[:city] }
          }

          expect(response).to redirect_to(login_path)
        end
      end

      context 'when pass invalid params' do
        it 'no creates new professional' do
          profession = FactoryBot.create(:profession)
          professional_params = FactoryBot.attributes_for(:professional)
          professional_data = { 'first_name' => professional_params[:first_name],
                                'last_name' => professional_params[:last_name],
                                'cpf' => professional_params[:cpf],
                                'email' => professional_params[:email],
                                'password' => professional_params[:password],
                                'profession_id' => profession.id }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { user_data: professional_data } }

          post '/create_professional', params: {
            professional: { postal_code: professional_params[:postal_code],
                            address:professional_params[:address],
                            number: professional_params[:number],
                            complement: professional_params[:complement],
                            district: professional_params[:district],
                            state: nil,
                            city: professional_params[:city] }
          }

          result = Professional.find_by(first_name: professional_params[:first_name])

          expect(result).to be_nil
        end

        it 'redirects to professional register page' do
          profession = FactoryBot.create(:profession)
          professional_params = FactoryBot.attributes_for(:professional)
          professional_data = { 'first_name' => professional_params[:first_name],
                                'last_name' => professional_params[:last_name],
                                'cpf' => professional_params[:cpf],
                                'email' => professional_params[:email],
                                'password' => professional_params[:password],
                                'profession_id' => profession.id }

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { user_data: professional_data } }

          post '/create_professional', params: {
            professional: { postal_code: professional_params[:postal_code],
                            address:professional_params[:address],
                            number: professional_params[:number],
                            complement: professional_params[:complement],
                            district: professional_params[:district],
                            state: nil,
                            city: professional_params[:city] }
          }

          expect(response).to redirect_to(registro_do_profissional_path)
        end
      end
    end
  end
end
