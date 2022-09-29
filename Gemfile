# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.7'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'

gem 'bootstrap', '~> 5.2.0'
gem 'correios-cep'
gem 'devise'
gem 'i18n'
gem 'jquery-mask-plugin'
gem 'jquery-rails'
gem 'nokogiri'
gem 'recaptcha'
gem 'repost'
gem 'rest-client'
gem 'strong_password', '~> 0.0.9'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'

  gem 'brakeman'
  gem 'rails-erd'
  gem 'rubocop', require: false
  gem 'rubycritic'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'

  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
