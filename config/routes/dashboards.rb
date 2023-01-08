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

post  'candidature/dashboard/apply',   to: 'dashboards/candidatures#apply'
delete 'candidature/dashboard/cancel', to: 'dashboards/candidatures#cancel'

get 'empresa/dashboard',                       to: 'dashboards/companies#index'
get 'empresa/dashboard/nova-vaga',             to: 'dashboards/companies#new'
get 'empresa/dashboard/editar/:vacant_job_id', to: 'dashboards/companies#edit', as: 'edit_company_vacant_job'
post 'empresa/dashboard/create',               to: 'dashboards/companies#create'

get 'profissional/dashboard', to: 'dashboards/professionals#index'
