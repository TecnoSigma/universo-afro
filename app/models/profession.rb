class Profession < ApplicationRecord
  validates :name,
            presence: { message: I18n.t('messages.errors.required_field') }

  has_many :professionals
  has_many :vacant_jobs
end

