# frozen_string_literal: true

class City < ApplicationRecord
  validates :name,
            presence: { message: I18n.t('messages.errors.required_field') }

  belongs_to :state
end
