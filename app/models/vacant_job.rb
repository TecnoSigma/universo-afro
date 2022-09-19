# frozen_string_literal: true

# class responsible by manage vacancies
class VacantJob < ApplicationRecord
  validates :name,
            :kind,
            :state,
            :city,
            presence: { message: I18n.t('messages.errors.required_field') }

  enum creator: { candidate: 1, company: 2 }

  belongs_to :candidate

  TYPES = ['Aprendiz',
    'Autônomo',
    'Estágio',
    'Freelance',
    'Meio período',
    'Tempo integral',
    'Temporário',
    'Trainee'
  ].freeze
end
