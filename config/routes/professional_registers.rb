# frozen_string_literal: true

get 'registro-do-profissional', to: 'professional_registers#index'
post 'create_professional',     to: 'professional_registers#create'
