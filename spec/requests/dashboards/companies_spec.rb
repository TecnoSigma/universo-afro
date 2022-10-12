# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboards::CompaniesController, type: :request do
  before(:each) do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { profile: 'any_profile' } }
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
