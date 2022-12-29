# frozen_string_literal: true

get   'candidato/dashboard',                               to: 'dashboards/candidates#index'
get   'candidato/dashboard/editar-perfil',                 to: 'dashboards/candidates#edit_profile'
get   'candidato/dashboard/vaga/:vacant_job_id',           to: 'dashboards/candidates#vacant_job_details',
                                                           as: 'vacant_job_details'
post  'candidato/dashboard/apply',                         to: 'dashboards/candidates#apply'
patch 'candidato/dashboard/update-avatar',                 to: 'dashboards/candidates#update_avatar'
patch 'candidato/dashboard/update-personal-data',          to: 'dashboards/candidates#update_personal_data'
patch 'candidato/dashboard/update-access-data',            to: 'dashboards/candidates#update_access_data'
patch 'candidato/dashboard/update-first-vacant-job-data',  to: 'dashboards/candidates#update_first_vacant_job_data'
patch 'candidato/dashboard/update-second-vacant-job-data', to: 'dashboards/candidates#update_second_vacant_job_data'

get 'empresa/dashboard',      to: 'dashboards/companies#index'
get 'profissional/dashboard', to: 'dashboards/professionals#index'
