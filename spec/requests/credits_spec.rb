# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreditsController, type: :request do
  describe 'GET actions' do
    describe '#index' do
      it 'renders credits page' do
        get '/creditos'

        expect(response).to render_template(:index)
      end
    end
  end
end
