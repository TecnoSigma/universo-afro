# frozen_string_literal: true

class Professional < ApplicationRecord
  validates :first_name,
            :last_name,
            :cpf,
            :email,
            :password,
            :address,
            :number,
            :district,
            :city,
            :state,
            :postal_code,
            presence: { message: I18n.t('messages.errors.required_field') }

  validates :cpf,
            uniqueness: { message: I18n.t('messages.errors.already_used') }

  belongs_to :profession

  enum status: Statuses::PROFESSIONAL
end
