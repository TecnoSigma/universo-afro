# frozen_string_literal: true

# class responsible by manage companies
class Company < ApplicationRecord
  include AvatarValidator
  include AfroIdGenerator

  validates :name,
            :nickname,
            :cnpj,
            :email,
            :password,
            :address,
            :number,
            :district,
            :city,
            :state,
            :postal_code,
            :afro_id,
            presence: { message: I18n.t('messages.errors.required_field') }

  validates :cnpj,
            uniqueness: { message: I18n.t('messages.errors.already_used') }

  has_many :company_vacant_jobs
  has_many :conferences

  enum status: Statuses::COMPANY
end
