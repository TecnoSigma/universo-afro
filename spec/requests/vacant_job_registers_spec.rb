# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VacantJobRegistersController, type: :request do
  before(:each) do
    allow_any_instance_of(ActionDispatch::Request)
              .to receive(:session) { { user_data: { any_data: 'anything' },
                                        candidate_data: { any_data: 'anything' } } }
  end

  describe 'GET actions' do
    describe '#first_vacant_job' do
      it 'renders access data information page' do
        get '/registro-da-vaga-1'

        expect(response).to render_template(:first_vacant_job)
      end
    end
  end
end
