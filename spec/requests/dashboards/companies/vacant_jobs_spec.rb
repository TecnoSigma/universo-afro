# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboards::Companies::VacantJobsController, type: :request do
  before(:each) do
    user = FactoryBot.create(:company)

    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session) { { profile: 'company', user_email: user.email, afro_id: user.afro_id } }
  end

  describe 'GET actions' do
    describe '#new' do
      it 'renders new vacant job page' do
        get '/empresa/dashboard/vaga/nova-vaga'

        expect(response).to render_template(:new)
      end
    end

    describe '#edit' do
      it 'renders company vacant job page' do
        details = 'any text'
        profession = FactoryBot.create(:profession)
        company = FactoryBot.create(:company, status: 'activated')
        vacant_job = FactoryBot.attributes_for(:vacant_job, remote: false)

        company_vacant_job = CompanyVacantJob.new(vacant_job)
        company_vacant_job.profession = profession
        company_vacant_job.company = company
        company_vacant_job.details = details
        company_vacant_job.save

        get "/empresa/dashboard/vaga/editar/#{company_vacant_job.vacant_job_id}"

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH actions' do
    describe '#update' do
      context 'when pass valid params' do
        it 'updates company vacant job data' do
          category = 'Meio Período'
          remote = '0'
          profession_name1 = 'Advogado'
          profession_name2 = 'Açogueiro'
          profession1 = FactoryBot.create(:profession, name: profession_name1)
          profession2 = FactoryBot.create(:profession, name: profession_name2)

          company = FactoryBot.create(:company, status: 'activated')

          company_vacant_job = FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company.id,
                                                 profession: profession1, category: category, remote: true)
          company_vacant_job.vacant_job_id = SecureRandom.hex(10)
          company_vacant_job.save

          patch '/empresa/dashboard/vaga/update',
            params: { vacant_job: { profession: profession2.name, remote: remote, vacant_job_id: company_vacant_job.vacant_job_id } }

          result1 = CompanyVacantJob.find_by_category(category).profession
          result2 = CompanyVacantJob.find_by_category(category).remote

          expect(result1).to eq(profession2)
          expect(result2).to eq(false)
        end

        it 'redirects to company dashboard' do
          category = 'Meio Período'
          remote = '0'
          profession_name1 = 'Advogado'
          profession_name2 = 'Açogueiro'
          profession1 = FactoryBot.create(:profession, name: profession_name1)
          profession2 = FactoryBot.create(:profession, name: profession_name2)

          company = FactoryBot.create(:company, status: 'activated')

          company_vacant_job = FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company.id,
                                                 profession: profession1, category: category, remote: true)
          company_vacant_job.vacant_job_id = SecureRandom.hex(10)
          company_vacant_job.save

          patch '/empresa/dashboard/vaga/update',
            params: { vacant_job: { profession: profession2.name, remote: remote, vacant_job_id: company_vacant_job.vacant_job_id } }

          expect(response).to redirect_to(empresa_dashboard_path)
        end

        it 'shows success message' do
          category = 'Meio Período'
          remote = '0'
          profession_name1 = 'Advogado'
          profession_name2 = 'Açogueiro'
          profession1 = FactoryBot.create(:profession, name: profession_name1)
          profession2 = FactoryBot.create(:profession, name: profession_name2)

          company = FactoryBot.create(:company, status: 'activated')

          company_vacant_job = FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company.id,
                                                 profession: profession1, category: category, remote: true)
          company_vacant_job.vacant_job_id = SecureRandom.hex(10)
          company_vacant_job.save

          patch '/empresa/dashboard/vaga/update',
            params: { vacant_job: { profession: profession2.name, remote: remote, vacant_job_id: company_vacant_job.vacant_job_id } }

          expect(flash[:notice]).to eq('Vaga atualizada com sucesso!')
        end
      end

      context 'when pass invalid params' do
        it 'no updates company vacant job data' do
          category = 'Meio período'
          remote = '0'
          profession_name1 = 'Advogado'
          profession_name2 = 'Açogueiro'
          profession1 = FactoryBot.create(:profession, name: profession_name1)
          profession2 = FactoryBot.create(:profession, name: profession_name2)

          company = FactoryBot.create(:company, status: 'activated')

          company_vacant_job = FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company.id,
                                                 profession: profession1, category: category, remote: true)
          company_vacant_job.vacant_job_id = SecureRandom.hex(10)
          company_vacant_job.save

          patch '/empresa/dashboard/vaga/update',
            params: { vacant_job: { profession: profession2.name, remote: remote, vacant_job_id: nil } }

          result1 = CompanyVacantJob.find_by_category(category).profession
          result2 = CompanyVacantJob.find_by_category(category).remote

          expect(result1).not_to eq(profession2)
          expect(result2).not_to eq(remote)
        end

        it 'redirects to company dashboard' do
          category = 'Meio Período'
          remote = nil
          profession_name1 = 'Advogado'
          profession_name2 = 'Açogueiro'
          profession1 = FactoryBot.create(:profession, name: profession_name1)
          profession2 = FactoryBot.create(:profession, name: profession_name2)

          company = FactoryBot.create(:company, status: 'activated')

          company_vacant_job = FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company.id,
                                                 profession: profession1, category: category, remote: true)
          company_vacant_job.vacant_job_id = SecureRandom.hex(10)
          company_vacant_job.save

          patch '/empresa/dashboard/vaga/update',
            params: { vacant_job: { profession: profession2.name, remote: remote, vacant_job_id: nil } }

          expect(response).to redirect_to(empresa_dashboard_path)
        end

        it 'shows error message' do
          category = 'Meio Período'
          remote = nil
          profession_name1 = 'Advogado'
          profession_name2 = 'Açogueiro'
          profession1 = FactoryBot.create(:profession, name: profession_name1)
          profession2 = FactoryBot.create(:profession, name: profession_name2)

          company = FactoryBot.create(:company, status: 'activated')

          company_vacant_job = FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company.id,
                                                 profession: profession1, category: category, remote: true)
          company_vacant_job.vacant_job_id = SecureRandom.hex(10)
          company_vacant_job.save

          patch '/empresa/dashboard/vaga/update',
            params: { vacant_job: { profession: profession2.name, remote: remote, vacant_job_id: nil } }

          expect(flash[:alert]).to eq('Erro na atualização da vaga!')
        end
      end
    end
  end

  describe 'POST actions' do
    describe '#create' do
      context 'when pass valid params' do
        it 'creates a new comoany vacant job' do
          profession = FactoryBot.create(:profession)
          category = 'Meio período'

          post '/empresa/dashboard/vaga/create',
            params: { vacant_job: { profession: profession.name,
                                    category: category,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: 'Espírito Santo',
                                    city: 'Baixo Guandu' } }

          result = CompanyVacantJob.find_by_category(category)

          expect(result).to be_present
        end

        it 'redirects to company dashboard' do
          profession = FactoryBot.create(:profession)
          category = 'Meio período'

          post '/empresa/dashboard/vaga/create',
            params: { vacant_job: { profession: profession.name,
                                    category: category,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: 'Espírito Santo',
                                    city: 'Baixo Guandu' } }

          expect(response).to redirect_to(empresa_dashboard_path)
        end

        it 'shows success message' do
          profession = FactoryBot.create(:profession)
          category = 'Meio período'

          post '/empresa/dashboard/vaga/create',
            params: { vacant_job: { profession: profession.name,
                                    category: category,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: 'Espírito Santo',
                                    city: 'Baixo Guandu' } }

          expect(flash[:notice]).to eq('Vaga criada com sucesso!')
        end
      end

      context 'when pass invalid params' do
        it 'no creates a new comoany vacant job' do
          profession = FactoryBot.create(:profession)
          state = 'São Paulo'

          post '/empresa/dashboard/vaga/create',
            params: { vacant_job: { profession: profession.name,
                                    category: nil,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: state,
                                    city: 'Baixo Guandu' } }

          result = CompanyVacantJob.find_by_state(state)

          expect(result).to be_nil
        end

        it 'redirects to new vacant job dashboard' do
          profession = FactoryBot.create(:profession)

          post '/empresa/dashboard/vaga/create',
            params: { vacant_job: { profession: profession.name,
                                    category: nil,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: 'Espírito Santo',
                                    city: 'Baixo Guandu' } }

          expect(response).to redirect_to(empresa_dashboard_vaga_nova_vaga_path)
        end

        it 'shows error message' do
          profession = FactoryBot.create(:profession)

          post '/empresa/dashboard/vaga/create',
            params: { vacant_job: { profession: profession.name,
                                    category: nil,
                                    availabled_quantity: '3',
                                    details: 'Teste\r\nde\r\nInclusão',
                                    remote: '1',
                                    state: 'Espírito Santo',
                                    city: 'Baixo Guandu' } }

          expect(flash[:alert]).to eq('Erro na criação de nova vaga!')
        end
      end
    end
  end
end
