# frozen_string_literal: true

# class responsible by manage vacancies
class VacantJob < ApplicationRecord
  validates :name,
            :category,
            :state,
            :city,
            presence: { message: I18n.t('messages.errors.required_field') }

  CATEGORIES= ['Aprendiz',
    'Autônomo',
    'Estágio',
    'Freelance',
    'Meio período',
    'Tempo integral',
    'Temporário',
    'Trainee'
  ].freeze
end
