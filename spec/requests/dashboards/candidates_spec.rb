# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboards::CandidatesController, type: :request do
  before(:each) do
    user = FactoryBot.create(:candidate)

    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session) { { profile: 'any_profile', user_email: user.email } }
  end

  describe 'GET actions' do
    describe '#index' do
      it 'renders candidates dashboard page' do
        get '/candidato/dashboard'

        expect(response).to render_template(:index)
      end
    end
  end
end
