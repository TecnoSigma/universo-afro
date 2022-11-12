# frozen_string_literal: true

class Logotype < ApplicationRecord
  validates :data,
            :filename,
            :mime_type,
            presence: { message: I18n.t('messages.errors.required_field') }

  belongs_to :company
end
