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
  end
end
