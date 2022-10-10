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
  end
end
