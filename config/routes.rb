Rails.application.routes.draw do
  get 'creditos', to: 'credits#index'

  get 'escolha-seu-perfil',          to: 'register_validations#choose_profile'
  get 'informe-os-dados-de-usuario', to: 'register_validations#inform_user_data'
  get 'confirme-seu-email',          to: 'register_validations#confirm_email'
  post 'store_user_profile',         to: 'register_validations#store_user_profile'
  post 'store_user_data',            to: 'register_validations#store_user_data'
  post 'resend_verification_code',   to: 'register_validations#resend_verification_code'
  post 'check_verification_code',    to: 'register_validations#check_verification_code'

  get 'users/cities', to: 'user_registers#cities'
  get 'users/address', to: 'user_registers#address'

  get 'registro-de-candidato', to: 'candidate_registers#index'
  post 'store_candidate_data', to: 'candidate_registers#store_candidate_data'
  post 'create_candidate',     to: 'candidate_registers#create'

  get 'registro-de-profissional', to: 'professional_registers#index'

  get 'registro-de-vaga-1', to: 'vacant_job_registers#first_vacant_job'
  get 'registro-de-vaga-2', to: 'vacant_job_registers#second_vacant_job'
  post 'store_first_vacant_job_data', to: 'vacant_job_registers#store_first_vacant_job_data'
  post 'store_second_vacant_job_data', to: 'vacant_job_registers#store_second_vacant_job_data'

  get 'candidato/login', to: 'logins#index'
end
