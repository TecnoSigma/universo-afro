# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardsController, type: :request do
  describe 'GET actions' do
    describe '#logout' do
      it 'redirects to login page' do
        get '/logout'

        expect(response).to redirect_to(login_path)
      end
    end
  end
end
