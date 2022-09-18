# frozen_string_literal: true

# Class responsible by manage avatars

# TODO: Alterar nome do model para candidate
class Candidate < ApplicationRecord
  validates :first_name,
            :last_name,
            :afro_id,
            :status,
            presence: { message: I18n.t('messages.errors.required_field') }

  has_one :avatar

  enum status: Statuses::CANDIDATE
end
