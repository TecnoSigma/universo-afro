# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboards::CandidaturesController, type: :request do
  before(:each) do
    user = FactoryBot.create(:candidate)

    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session) { { profile: 'any_profile', user_email: user.email, afro_id: user.afro_id } }
  end

  describe 'POST actions' do
    describe '#apply' do
      context 'when pass valid params' do
        it 'associates candidate with company vacant job' do
          profession = FactoryBot.create(:profession, name: 'Rei')

          vacant_job1 = FactoryBot.attributes_for(:vacant_job, details: 'Any text', remote: false, alert: false)
          vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          company = FactoryBot.create(:company)
          company_vacant_job = CompanyVacantJob.new(vacant_job1)
          company_vacant_job.profession = profession
          company_vacant_job.company = company
          company_vacant_job.save!

          candidate = FactoryBot.create(:candidate)
          candidate_vacant_job = CandidateVacantJob.new(vacant_job2)
          candidate_vacant_job.profession = profession
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.save!

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          post '/candidature/dashboard/apply', params: { vacant_job: { id: company_vacant_job.vacant_job_id } }

          result = Candidature
                     .where(company_vacant_jobs: [company_vacant_job], candidate_vacant_job: candidate_vacant_job)
                     .first

          expect(result).to be_present
        end

        it 'redirects to vacant job details page' do
          profession = FactoryBot.create(:profession, name: 'Rei')

          vacant_job1 = FactoryBot.attributes_for(:vacant_job, details: 'Any text', remote: false, alert: false)
          vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          company = FactoryBot.create(:company)
          company_vacant_job = CompanyVacantJob.new(vacant_job1)
          company_vacant_job.profession = profession
          company_vacant_job.company = company
          company_vacant_job.save!

          candidate = FactoryBot.create(:candidate)
          candidate_vacant_job = CandidateVacantJob.new(vacant_job2)
          candidate_vacant_job.profession = profession
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.save!

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          post '/candidature/dashboard/apply', params: { vacant_job: { id: company_vacant_job.vacant_job_id } }

          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows success message' do
          profession = FactoryBot.create(:profession, name: 'Rei')

          vacant_job1 = FactoryBot.attributes_for(:vacant_job, details: 'Any text', remote: false, alert: false)
          vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          company = FactoryBot.create(:company)
          company_vacant_job = CompanyVacantJob.new(vacant_job1)
          company_vacant_job.profession = profession
          company_vacant_job.company = company
          company_vacant_job.save!

          candidate = FactoryBot.create(:candidate)
          candidate_vacant_job = CandidateVacantJob.new(vacant_job2)
          candidate_vacant_job.profession = profession
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.save!

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          post '/candidature/dashboard/apply', params: { vacant_job: { id: company_vacant_job.vacant_job_id } }

          expect(flash[:notice]).to eq('Candidatura efetuada com sucesso!')
        end
      end

      context 'when pass invalid params' do
        it 'no associates candidate with company vacant job' do
          profession = FactoryBot.create(:profession, name: 'Rei')

          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          candidate = FactoryBot.create(:candidate)
          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.save!

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          post '/candidature/dashboard/apply', params: { vacant_job_id: nil }

          result = Candidature.where(candidate_vacant_job: candidate_vacant_job).first

          expect(result).to be_nil
        end

        it 'redirects to vacant job details page' do
          profession = FactoryBot.create(:profession, name: 'Rei')

          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          candidate = FactoryBot.create(:candidate)
          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.save!

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          post '/candidature/dashboard/apply', params: { vacant_job_id: nil }

          expect(response).to redirect_to(candidato_dashboard_path)
        end

        it 'shows error message' do
          profession = FactoryBot.create(:profession, name: 'Rei')

          vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

          candidate = FactoryBot.create(:candidate)
          candidate_vacant_job = CandidateVacantJob.new(vacant_job)
          candidate_vacant_job.profession = profession
          candidate_vacant_job.candidate = candidate
          candidate_vacant_job.save!

          allow_any_instance_of(ActionDispatch::Request)
            .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

          post '/candidature/dashboard/apply', params: { vacant_job_id: nil }

          expect(flash[:alert]).to eq('Erro ao candidatar-se à vaga!')
        end
      end
    end

    describe 'DELETE actions' do
      describe '#cancel' do
        context 'when pass valid params' do
          it 'cancels candidature' do
            profession = FactoryBot.create(:profession, name: 'Rei')

            vacant_job1 = FactoryBot.attributes_for(:vacant_job, details: 'Any text', remote: false, alert: false)
            vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

            company = FactoryBot.create(:company)
            company_vacant_job = CompanyVacantJob.new(vacant_job1)
            company_vacant_job.profession = profession
            company_vacant_job.company = company
            company_vacant_job.save!

            candidate = FactoryBot.create(:candidate)
            candidate_vacant_job = CandidateVacantJob.new(vacant_job2)
            candidate_vacant_job.profession = profession
            candidate_vacant_job.candidate = candidate
            candidate_vacant_job.save!

            candidature = Candidature
              .create(company_vacant_job: company_vacant_job, candidate_vacant_job: candidate_vacant_job)

            allow_any_instance_of(ActionDispatch::Request)
              .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

            delete '/candidature/dashboard/cancel', params: { candidature: { id: candidature.id } }

            result = Candidature
              .where(company_vacant_jobs: [company_vacant_job], candidate_vacant_job: candidate_vacant_job)
              .first

            expect(result).to be_nil
          end

          it 'redirects to candidate dashboard' do
            profession = FactoryBot.create(:profession, name: 'Rei')

            vacant_job1 = FactoryBot.attributes_for(:vacant_job, details: 'Any text', remote: false, alert: false)
            vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

            company = FactoryBot.create(:company)
            company_vacant_job = CompanyVacantJob.new(vacant_job1)
            company_vacant_job.profession = profession
            company_vacant_job.company = company
            company_vacant_job.save!

            candidate = FactoryBot.create(:candidate)
            candidate_vacant_job = CandidateVacantJob.new(vacant_job2)
            candidate_vacant_job.profession = profession
            candidate_vacant_job.candidate = candidate
            candidate_vacant_job.save!

            candidature = Candidature                                                                                               .create(company_vacant_job: company_vacant_job, candidate_vacant_job: candidate_vacant_job)

            allow_any_instance_of(ActionDispatch::Request)
              .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

            delete '/candidature/dashboard/cancel', params: { candidature: { id: candidature.id } }

            expect(response).to redirect_to(candidato_dashboard_path)
          end

          it 'shows success message' do
            profession = FactoryBot.create(:profession, name: 'Rei')

            vacant_job1 = FactoryBot.attributes_for(:vacant_job, details: 'Any text', remote: false, alert: false)
            vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

            company = FactoryBot.create(:company)
            company_vacant_job = CompanyVacantJob.new(vacant_job1)
            company_vacant_job.profession = profession
            company_vacant_job.company = company
            company_vacant_job.save!

            candidate = FactoryBot.create(:candidate)
            candidate_vacant_job = CandidateVacantJob.new(vacant_job2)
            candidate_vacant_job.profession = profession
            candidate_vacant_job.candidate = candidate
            candidate_vacant_job.save!

            candidature = Candidature                                                                                               .create(company_vacant_job: company_vacant_job, candidate_vacant_job: candidate_vacant_job)

            allow_any_instance_of(ActionDispatch::Request)
              .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

            delete '/candidature/dashboard/cancel', params: { candidature: { id: candidature.id } }

            expect(flash[:notice]).to eq('Candidatura cancelada com sucesso!')
          end
        end

        context 'when occurs errors' do
          it 'no cancel candidature' do
            profession = FactoryBot.create(:profession, name: 'Rei')

            vacant_job1 = FactoryBot.attributes_for(:vacant_job, details: 'Any text', remote: false, alert: false)
            vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

            company = FactoryBot.create(:company)
            company_vacant_job = CompanyVacantJob.new(vacant_job1)
            company_vacant_job.profession = profession
            company_vacant_job.company = company
            company_vacant_job.save!

            candidate = FactoryBot.create(:candidate)
            candidate_vacant_job = CandidateVacantJob.new(vacant_job2)
            candidate_vacant_job.profession = profession
            candidate_vacant_job.candidate = candidate
            candidate_vacant_job.save!

            candidature = Candidature                                                                                               .create(company_vacant_job: company_vacant_job, candidate_vacant_job: candidate_vacant_job)

            allow_any_instance_of(ActionDispatch::Request)
              .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

            allow(Candidature).to receive(:find_by) { raise StandardError }

            delete '/candidature/dashboard/cancel', params: { candidature: { id: candidature.id } }

            result = Candidature
              .where(company_vacant_jobs: [company_vacant_job], candidate_vacant_job: candidate_vacant_job)
              .first

            expect(result).to be_present
          end

          it 'shows error message' do
            profession = FactoryBot.create(:profession, name: 'Rei')

            vacant_job1 = FactoryBot.attributes_for(:vacant_job, details: 'Any text', remote: false, alert: false)
            vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

            company = FactoryBot.create(:company)
            company_vacant_job = CompanyVacantJob.new(vacant_job1)
            company_vacant_job.profession = profession
            company_vacant_job.company = company
            company_vacant_job.save!

            candidate = FactoryBot.create(:candidate)
            candidate_vacant_job = CandidateVacantJob.new(vacant_job2)
            candidate_vacant_job.profession = profession
            candidate_vacant_job.candidate = candidate
            candidate_vacant_job.save!

            candidature = Candidature                                                                                               .create(company_vacant_job: company_vacant_job, candidate_vacant_job: candidate_vacant_job)

            allow_any_instance_of(ActionDispatch::Request)
              .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

            allow(Candidature).to receive(:find_by) { raise StandardError }

            delete '/candidature/dashboard/cancel', params: { candidature: { id: candidature.id } }

            expect(flash[:alert]).to eq('Erro ao cancelar candidatura!')
          end

          it 'redirects to candidate dashboard' do
            profession = FactoryBot.create(:profession, name: 'Rei')

            vacant_job1 = FactoryBot.attributes_for(:vacant_job, details: 'Any text', remote: false, alert: false)
            vacant_job2 = FactoryBot.attributes_for(:vacant_job, remote: false, alert: false)

            company = FactoryBot.create(:company)
            company_vacant_job = CompanyVacantJob.new(vacant_job1)
            company_vacant_job.profession = profession
            company_vacant_job.company = company
            company_vacant_job.save!

            candidate = FactoryBot.create(:candidate)
            candidate_vacant_job = CandidateVacantJob.new(vacant_job2)
            candidate_vacant_job.profession = profession
            candidate_vacant_job.candidate = candidate
            candidate_vacant_job.save!

            candidature = Candidature                                                                                               .create(company_vacant_job: company_vacant_job, candidate_vacant_job: candidate_vacant_job)

            allow_any_instance_of(ActionDispatch::Request)
              .to receive(:session) { { profile: 'candidate', afro_id: candidate.afro_id } }

            allow(Candidature).to receive(:find_by) { raise StandardError }

            delete '/candidature/dashboard/cancel', params: { candidature: { id: candidature.id } }

            expect(response).to redirect_to(candidato_dashboard_path)
          end
        end
      end
    end
  end
end
