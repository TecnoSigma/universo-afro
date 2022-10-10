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

  #describe 'POST actions' do
  #  describe '#send_password' do
  #    profile_data = FactoeyBot.create(profile)

  #    post '/send_password', params: { profile: profile_data.profile, email: profile_data.email }
  #  end
  #end
end
