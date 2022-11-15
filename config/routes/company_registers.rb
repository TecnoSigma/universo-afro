# frozen_string_literal: true

get 'registro-da-empresa', to: 'company_registers#index'
post 'create_company',     to: 'company_registers#create'
