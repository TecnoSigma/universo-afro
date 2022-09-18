Rails.application.routes.draw do
  get 'creditos', to: 'credits#index'

  get 'escolha-seu-perfil',          to: 'registers#choose_profile'
  get 'informe-os-dados-de-usuario', to: 'registers#inform_user_data'
  get 'confirme-seu-email',          to: 'registers#confirm_email'
  post 'store_user_profile',         to: 'registers#store_user_profile'
  post 'store_user_data',            to: 'registers#store_user_data'
  post 'resend_verification_code',   to: 'registers#resend_verification_code'
  post 'check_verification_code',    to: 'registers#check_verification_code'
end
