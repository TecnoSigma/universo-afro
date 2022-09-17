Rails.application.routes.draw do
  get 'escolha-seu-perfil',           to: 'registers#choose_profile'
  get 'informe-os-dados-de-usuario',  to: 'registers#inform_user_data'
  post 'store_user_profile',          to: 'registers#store_user_profile'
  post 'store_user_data',             to: 'registers#store_user_data'
end
