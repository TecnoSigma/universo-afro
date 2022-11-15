# frozen_string_literal: true

get 'escolha-seu-perfil',          to: 'register_validations#choose_profile'
get 'informe-os-dados-de-usuario', to: 'register_validations#inform_user_data'
get 'confirme-seu-email',          to: 'register_validations#confirm_email'
post 'store_user_profile',         to: 'register_validations#store_user_profile'
post 'store_user_data',            to: 'register_validations#store_user_data'
post 'resend_verification_code',   to: 'register_validations#resend_verification_code'
post 'check_verification_code',    to: 'register_validations#check_verification_code'
