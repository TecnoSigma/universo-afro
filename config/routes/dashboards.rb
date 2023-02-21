# frozen_string_literal: true

get 'logout', to: 'dashboards#logout'

get   'candidato/dashboard',                               to: 'dashboards/candidates#index'
get   'candidato/dashboard/editar-perfil',                 to: 'dashboards/candidates#edit_profile'
get   'candidato/dashboard/vaga/:vacant_job_id',           to: 'dashboards/candidates#vacant_job_details',
                                                           as: 'vacant_job_details'
patch 'candidato/dashboard/update-avatar',                 to: 'dashboards/candidates#update_avatar'
patch 'candidato/dashboard/update-personal-data',          to: 'dashboards/candidates#update_personal_data'
patch 'candidato/dashboard/update-access-data',            to: 'dashboards/candidates#update_access_data'
patch 'candidato/dashboard/update-first-vacant-job-data',  to: 'dashboards/candidates#update_first_vacant_job_data'
patch 'candidato/dashboard/update-second-vacant-job-data', to: 'dashboards/candidates#update_second_vacant_job_data'

post  'dashboard/conference/create',                     to: 'dashboards/conferences#create'
patch 'dashboard/conference/accept/:conference_afro_id', to: 'dashboards/conferences#accept', as: 'accept_conference'
patch 'dashboard/conference/refuse/:conference_afro_id', to: 'dashboards/conferences#refuse', as: 'refuse_conference'

post   'dashboard/candidature/apply',  to: 'dashboards/candidatures#apply'
delete 'dashboard/candidature/cancel', to: 'dashboards/candidatures#cancel'

get 'empresa/dashboard',                        to: 'dashboards/companies#index'
get 'empresa/dashboard/editar-perfil',          to: 'dashboards/companies#edit_profile'
patch 'empresa/dashboard/update-avatar',        to: 'dashboards/companies#update_avatar'
patch 'empresa/dashboard/update-personal-data', to: 'dashboards/companies#update_personal_data'
patch 'empresa/dashboard/update-access-data',   to: 'dashboards/companies#update_access_data'

get 'empresa/dashboard/perfil-do-candidato/:candidate_name', to: 'dashboards/companies/candidates#profile',
                                                             as: 'candidate_profile'

get    'empresa/dashboard/vaga/nova-vaga',             to: 'dashboards/companies/vacant_jobs#new'
get    'empresa/dashboard/vaga/editar/:vacant_job_id', to: 'dashboards/companies/vacant_jobs#edit',
                                                       as: 'edit_company_vacant_job'
post   'empresa/dashboard/vaga/create',                to: 'dashboards/companies/vacant_jobs#create'
patch  'empresa/dashboard/vaga/update',                to: 'dashboards/companies/vacant_jobs#update'
delete 'empresa/dashboard/vaga/cancel/:vacant_job_id', to: 'dashboards/companies/vacant_jobs#cancel',
                                                       as: 'cancel_company_vacant_job'

get 'profissional/dashboard', to: 'dashboards/professionals#index'
