# frozen_string_literal: true

get 'registro-do-candidato', to: 'candidate_registers#index'
post 'store_candidate_data', to: 'candidate_registers#store_candidate_data'
post 'create_candidate',     to: 'candidate_registers#create'
