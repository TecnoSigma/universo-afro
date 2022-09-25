# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfessionalRegistersController, type: :request do
  before(:each) do
    professional_params = FactoryBot.attributes_for(:professional)
    professional_data = { first_name: professional_params[:first_name],
                       last_name: professional_params[:last_name],
                       cpf: professional_params[:cpf],
                       email: professional_params[:email],
                       password: professional_params[:password],
                       state: professional_params[:state],
                       city: professional_params[:city] }

    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session) { { user_data: professional_data } }
  end

  describe 'GET actions' do
    describe '#index' do
      it 'renders index page' do
        get '/registro-de-profissional'

        expect(response).to render_template(:index)
      end
    end
  end
end
