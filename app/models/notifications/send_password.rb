# frozen_string_literal: true

module Notifications
  # Class reponsible by notification of password send
  class SendPassword
    include Notifications::Configurations

    attr_reader :email, :password, :subject, :body

    def initialize(email:, password:)
      @email = email
      @password = password
      @subject = I18n.t('notifications.send_password.subject')
      @body = I18n.t('notifications.send_password.body', password: password)
    end
  end
end
