# frozen_string_literal: true

get 'login',                       to: 'logins#index'
get 'enviar_senha',                to: 'logins#send_password'
post 'send_password_notification', to: 'logins#send_password_notification'
post 'validate_access',            to: 'logins#validate_access'
