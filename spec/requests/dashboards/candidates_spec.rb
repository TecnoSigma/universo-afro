# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboards::CandidatesController, type: :request do
  before(:each) do
    user = FactoryBot.create(:candidate)

    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session) { { profile: 'any_profile', user_email: user.email, afro_id: user.afro_id } }
  end

  describe 'GET actions' do
    describe '#index' do
      it 'renders candidates dashboard page' do
        get '/candidato/dashboard'

        expect(response).to render_template(:index)
      end
    end

    describe '#edit_profile' do
      it 'renders candidate edition page' do
        get '/candidato/dashboard/editar-perfil'

        expect(response).to render_template(:edit_profile)
      end
    end
  end

  describe 'PATCH actions' do
    describe '#update_access_data' do
      context 'when pass valid params' do
        it 'updates candidate password' do
          candidate = FactoryBot.create(:candidate)

          new_password = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-access-data',
            params: { candidate: { password: new_password, confirm_password: new_password } }

          result = Candidate.find_by_afro_id(candidate.afro_id).password

          expect(result).to eq(new_password)
        end

        it 'shows success message' do
          candidate = FactoryBot.create(:candidate)

          new_password = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-access-data',
            params: { candidate: { password: new_password, confirm_password: new_password } }

          expect(flash[:notice]).to eq('Dados atualizados com sucesso!')
        end

        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)

          new_password = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-access-data',
            params: { candidate: { password: new_password, confirm_password: new_password } }

          expect(response).to redirect_to(candidato_dashboard_path)
        end
      end

      context 'when pass invalid params' do
        it 'no updates candidate password' do
          candidate = FactoryBot.create(:candidate)

          new_password = 'test1234'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-access-data',
            params: { candidate: { password: new_password, confirm_password: new_password } }

          result = Candidate.find_by_afro_id(candidate.afro_id).password

          expect(result).not_to eq(new_password)
        end

        it 'shows error message' do
          candidate = FactoryBot.create(:candidate)

          new_password = 'test1234'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-access-data',
            params: { candidate: { password: new_password, confirm_password: new_password } }

          expect(flash[:alert]).to eq('Erro na atualização dos dados!')
        end

        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)

          new_password = 'test1234'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-access-data',
            params: { candidate: { password: new_password, confirm_password: new_password } }

          expect(response).to redirect_to(candidato_dashboard_path)
        end
      end

      context 'when pass invalid password confirmation' do
        it 'no updates candidate password' do
          candidate = FactoryBot.create(:candidate)

          new_password1 = SecureRandom.hex
          new_password2 = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-access-data',
            params: { candidate: { password: new_password1, confirm_password: new_password2 } }

          result = Candidate.find_by_afro_id(candidate.afro_id).password

          expect(result).not_to eq(new_password1)
        end

        it 'shows error message' do
          candidate = FactoryBot.create(:candidate)

          new_password1 = SecureRandom.hex
          new_password2 = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-access-data',
            params: { candidate: { password: new_password1, confirm_password: new_password2 } }

          expect(flash[:alert]).to eq('Erro na atualização dos dados!')
        end

        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)

          new_password1 = SecureRandom.hex
          new_password2 = SecureRandom.hex

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-access-data',
            params: { candidate: { password: new_password1, confirm_password: new_password2 } }

          expect(response).to redirect_to(candidato_dashboard_path)
        end
      end
    end

        describe '#update_first_vacant_job' do
      context 'when pass valid data' do
        it 'updates first vacant job data' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = 'Central City'

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-first-vacant-job-data',
            params: { first_vacant_job: { profession_id: profession2.id,
                                          category: candidate_vacant_job.category,
                                          state: candidate_vacant_job.state,
                                          city: new_city,
                                          remote: true,
                                          alert: candidate_vacant_job.alert } }

          result1 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.first.city
          result2 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.first.remote
          result3 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.first.profession.id

          expect(result1).to eq(new_city)
          expect(result2).to eq(true)
          expect(result3).to eq(profession2.id)
        end

        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = 'Central City'

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-first-vacant-job-data',
            params: { first_vacant_job: { profession_id: profession2.id,
                                          category: candidate_vacant_job.category,
                                          state: candidate_vacant_job.state,
                                          city: new_city,
                                          remote: true,
                                          alert: candidate_vacant_job.alert } }


          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows show message' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = 'Central City'

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-first-vacant-job-data',
            params: { first_vacant_job: { profession_id: profession2.id,
                                          category: candidate_vacant_job.category,
                                          state: candidate_vacant_job.state,
                                          city: new_city,
                                          remote: true,
                                          alert: candidate_vacant_job.alert } }

          expect(flash[:notice]).to eq('Dados atualizados com sucesso!')
        end
      end

      context 'when pass invalid data' do
        it 'no updates first vacant job data' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = ''

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-first-vacant-job-data',
            params: { first_vacant_job: { profession_id: profession2.id,
                                          category: candidate_vacant_job.category,
                                          state: candidate_vacant_job.state,
                                          city: new_city,
                                          remote: true,
                                          alert: candidate_vacant_job.alert } }

          result1 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.first.city
          result2 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.first.remote
          result3 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.first.profession.id

          expect(result1).not_to eq(new_city)
          expect(result2).not_to eq(true)
          expect(result3).not_to eq(profession2.id)
        end

        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = ''

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-first-vacant-job-data',
            params: { first_vacant_job: { profession_id: profession2.id,
                                          category: candidate_vacant_job.category,
                                          state: candidate_vacant_job.state,
                                          city: new_city,
                                          remote: true,
                                          alert: candidate_vacant_job.alert } }


          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows error message' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = ''

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-first-vacant-job-data',
            params: { first_vacant_job: { profession_id: profession2.id,
                                          category: candidate_vacant_job.category,
                                          state: candidate_vacant_job.state,
                                          city: new_city,
                                          remote: true,
                                          alert: candidate_vacant_job.alert } }

          expect(flash[:alert]).to eq('Erro na atualização dos dados!')
        end
      end
    end

    describe '#update_second_vacant_job' do
      context 'when pass valid data' do
        it 'updates second vacant job data' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = 'Central City'

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-second-vacant-job-data',
            params: { second_vacant_job: { profession_id: profession2.id,
                                           category: candidate_vacant_job.category,
                                           state: candidate_vacant_job.state,
                                           city: new_city,
                                           remote: true,
                                           alert: candidate_vacant_job.alert } }

          result1 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.last.city
          result2 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.last.remote
          result3 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.last.profession.id

          expect(result1).to eq(new_city)
          expect(result2).to eq(true)
          expect(result3).to eq(profession2.id)
        end

        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = 'Central City'

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-second-vacant-job-data',
            params: { second_vacant_job: { profession_id: profession2.id,
                                           category: candidate_vacant_job.category,
                                           state: candidate_vacant_job.state,
                                           city: new_city,
                                           remote: true,
                                           alert: candidate_vacant_job.alert } }


          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows show message' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = 'Central City'

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-second-vacant-job-data',
            params: { second_vacant_job: { profession_id: profession2.id,
                                           category: candidate_vacant_job.category,
                                           state: candidate_vacant_job.state,
                                           city: new_city,
                                           remote: true,
                                           alert: candidate_vacant_job.alert } }

          expect(flash[:notice]).to eq('Dados atualizados com sucesso!')
        end
      end

      context 'when pass invalid data' do
        it 'no updates first vacant job data' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = ''

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-second-vacant-job-data',
            params: { second_vacant_job: { profession_id: profession2.id,
                                           category: candidate_vacant_job.category,
                                           state: candidate_vacant_job.state,
                                           city: new_city,
                                           remote: true,
                                           alert: candidate_vacant_job.alert } }

          result1 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.last.city
          result2 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.last.remote
          result3 = Candidate.find_by(id: candidate.id).candidate_vacant_jobs.last.profession.id

          expect(result1).not_to eq(new_city)
          expect(result2).not_to eq(true)
          expect(result3).not_to eq(profession2.id)
        end

        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = ''

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-second-vacant-job-data',
            params: { second_vacant_job: { profession_id: profession2.id,
                                           category: candidate_vacant_job.category,
                                           state: candidate_vacant_job.state,
                                           city: new_city,
                                           remote: true,
                                           alert: candidate_vacant_job.alert } }


          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows error message' do
          candidate = FactoryBot.create(:candidate)
          profession1 = FactoryBot.create(:profession)
          profession2 = FactoryBot.create(:profession)
          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          new_city = ''

          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession1
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.remote = false
          candidate_vacant_job.save

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-second-vacant-job-data',
            params: { second_vacant_job: { profession_id: profession2.id,
                                           category: candidate_vacant_job.category,
                                           state: candidate_vacant_job.state,
                                           city: new_city,
                                           remote: true,
                                           alert: candidate_vacant_job.alert } }

          expect(flash[:alert]).to eq('Erro na atualização dos dados!')
        end
      end
    end

    describe '#update_personal_data' do
      context 'when pass valid params' do
        it 'updates personal data' do
          candidate = FactoryBot.create(:candidate)

          last_name = 'Souza'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-personal-data',
            params: { candidate: { first_name: candidate.first_name,
                                   last_name: last_name,
                                   state: candidate.state,
                                   city: candidate.city,
                                   ethnicity_self_declaration: candidate.ethnicity_self_declaration } }

          result = Candidate.find_by_afro_id(candidate.afro_id).last_name

          expect(result).to eq(last_name)
        end

        it 'shows success message' do
          candidate = FactoryBot.create(:candidate)

          last_name = 'Souza'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-personal-data',
            params: { candidate: { first_name: candidate.first_name,
                                   last_name: last_name,
                                   state: candidate.state,
                                   city: candidate.city,
                                   ethnicity_self_declaration: candidate.ethnicity_self_declaration } }

          expect(flash[:notice]).to eq('Dados atualizados com sucesso!')
        end

        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)

          last_name = 'Souza'

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-personal-data',
            params: { candidate: { first_name: candidate.first_name,
                                   last_name: last_name,
                                   state: candidate.state,
                                   city: candidate.city,
                                   ethnicity_self_declaration: candidate.ethnicity_self_declaration } }

          expect(response).to redirect_to(candidato_dashboard_path)
        end
      end

      context 'when pass invalid params' do
        it 'no updates personal data' do
          candidate = FactoryBot.create(:candidate)

          last_name = nil

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-personal-data',
            params: { candidate: { first_name: candidate.first_name,
                                   last_name: last_name,
                                   state: candidate.state,
                                   city: candidate.city,
                                   ethnicity_self_declaration: candidate.ethnicity_self_declaration } }

          result = Candidate.find_by_afro_id(candidate.afro_id).last_name

          expect(result).not_to eq(last_name)
        end

        it 'shows errors message' do
          candidate = FactoryBot.create(:candidate)

          last_name = nil

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-personal-data',
            params: { candidate: { first_name: candidate.first_name,
                                   last_name: last_name,
                                   state: candidate.state,
                                   city: candidate.city,
                                   ethnicity_self_declaration: candidate.ethnicity_self_declaration } }

          expect(flash[:alert]).to eq('Erro na atualização dos dados!')
        end

        it 'redirects to candidate dashboard' do
          candidate = FactoryBot.create(:candidate)

          last_name = nil

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          patch '/candidato/dashboard/update-personal-data',
            params: { candidate: { first_name: candidate.first_name,
                                   last_name: last_name,
                                   state: candidate.state,
                                   city: candidate.city,
                                   ethnicity_self_declaration: candidate.ethnicity_self_declaration } }

          expect(response).to redirect_to(candidato_dashboard_path)
        end
      end
    end

    describe '#update_avatar' do
      context 'when pass valid file' do
        it 'updates candidate avatar image' do
          user = Candidate.last

          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          patch '/candidato/dashboard/update-avatar', params: { candidate: { avatar: new_avatar } }

          result = user.avatar.attached?

          expect(result).to eq(true)
        end

        it 'redirects to candidate dashboard page' do
          user = Candidate.last

          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          patch '/candidato/dashboard/update-avatar', params: { candidate: { avatar: new_avatar } }

          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows success message' do
          user = Candidate.last

          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          patch '/candidato/dashboard/update-avatar', params: { candidate: { avatar: new_avatar } }

          expect(flash[:notice]).to eq('Dados atualizados com sucesso!')
        end
      end

      context 'when occurs errors' do
        it 'redirects to candidate dashboard page' do
          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          allow(Candidate).to receive_message_chain(:find_by, :avatar, :attach) { raise StandardError }

          patch '/candidato/dashboard/update-avatar', params: { candidate: { avatar: new_avatar } }

          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows error message' do
          new_avatar = fixture_file_upload('spec/fixtures/avatar.png', 'image/png')

          allow(Candidate).to receive_message_chain(:find_by, :avatar, :attach) { raise StandardError }

          patch '/candidato/dashboard/update-avatar', params: { candidate: { avatar: new_avatar } }

          expect(flash[:alert]).to eq('Erro na atualização dos dados!')
        end
      end
    end
  end
end
