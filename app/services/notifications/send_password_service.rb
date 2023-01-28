# frozen_string_literal: true

require 'sendgrid-ruby'

module Notifications
  # class responsible by send passwords to users
  class SendPasswordService
    include Notifications::Configurations

    attr_reader :name, :email, :subject, :body

    def initialize(email:, password:, name: nil)
      @email = email
      @name = name
      @subject = I18n.t('notifications.send_password.subject')
      @body = I18n.t('notifications.send_password.body', password: password)
    end
  end
end
