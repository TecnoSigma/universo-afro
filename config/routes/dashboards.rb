# frozen_string_literal: true

get 'candidato/dashboard',    to: 'dashboards/candidates#index'
get 'empresa/dashboard',      to: 'dashboards/companies#index'
get 'profissional/dashboard', to: 'dashboards/professionals#index'
