# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module UniversoAfro
  # class responsible by manage application
  class Application < Rails::Application
    config.load_defaults 6.1

    config.i18n.default_locale = 'pt-BR'

    config.active_job.queue_adapter = :sidekiq

    config.autoloader = :classic

    config.autoload_paths += %W[
      #{config.root}/lib
      #{config.root}/app/builders
      #{config.root}/app/exceptions
      #{config.root}/app/presenters
      #{config.root}/app/services
    ]

    # Extensions
    require 'extensions/string'
  end
end
