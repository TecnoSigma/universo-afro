# frozen_string_literal: true

# class responsible by manage states
class State < ApplicationRecord
  validates :name,
            :uf,
            :external_id,
            presence: { message: I18n.t('messages.errors.required_field') }

  has_many :cities

  def cities_list
    cities.pluck(:name).sort
  end
end
