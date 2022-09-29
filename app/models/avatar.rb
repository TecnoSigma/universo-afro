# frozen_string_literal: true

class Avatar < ApplicationRecord
  validates :name,
            :data,
            :filename,
            :mime_type,
            presence: { message: I18n.t('messages.errors.required_field') }

  belongs_to :candidate
end
