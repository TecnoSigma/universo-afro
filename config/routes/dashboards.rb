# frozen_string_literal: true

get 'candidato/dashboard',               to: 'dashboards/candidates#index'
get 'candidato/dashboard/editar-perfil', to: 'dashboards/candidates#edit_profile'

get 'empresa/dashboard',      to: 'dashboards/companies#index'
get 'profissional/dashboard', to: 'dashboards/professionals#index'
