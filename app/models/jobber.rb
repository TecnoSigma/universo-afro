# frozen_string_literal: true

# Class responsible by manage avatars

class Jobber < ApplicationRecord
  validates :first_name,
            :last_name,
            :afro_id,
            :status,
            presence: { message: I18n.t('messages.errors.required_field') }

  has_one :avatar

  enum status: Statuses::JOBBER
end
