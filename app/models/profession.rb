class Profession < ApplicationRecord
  validates :name,
            presence: { message: I18n.t('messages.errors.required_field') }

  belongs_to :candidate, optional: true
end

