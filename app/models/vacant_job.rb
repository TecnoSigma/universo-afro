# frozen_string_literal: true

# class responsible by manage vacancies
class VacantJob < ApplicationRecord
  validates :category,
            :state,
            :city,
            :status,
            presence: { message: I18n.t('messages.errors.required_field') }

  belongs_to :profession

  enum status: Statuses::VACANT_JOB

  CATEGORIES = ['Aprendiz',
                'Autônomo',
                'Estágio',
                'Freelance',
                'Meio período',
                'Tempo integral',
                'Temporário',
                'Trainee'].freeze
end
